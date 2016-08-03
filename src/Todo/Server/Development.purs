module Todo.Server.Development where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Function.Uncurried (Fn2, Fn3, runFn2)
import Node.Express.App (App, listenHttp, useExternal, get)
import Node.Express.Handler (HandlerM())
import Node.Express.Response (send)
import Node.Express.Types (EXPRESS, Response, Request, ExpressM)
import Node.HTTP (Server)

foreign import data CONFIG :: !
foreign import data COMPILER :: !
foreign import data Compiler :: *

foreign import morgan :: forall eff.
  String -> Fn3 Request Response (ExpressM eff Unit) (ExpressM eff Unit)
foreign import devMiddleware :: forall eff.
  Fn2 Compiler { publicPath :: String
  , stats :: { colors :: Boolean, chunks :: Boolean }
  , watchOptions :: { aggregateTimeout :: Int } }
  (Fn3 Request Response (ExpressM eff Unit) (ExpressM eff Unit))

foreign import getPublicPath :: forall eff.
  Eff (config :: CONFIG | eff) String
foreign import getCompiler :: forall eff.
  Eff (compiler :: COMPILER | eff) Compiler
foreign import getIndexHtml :: forall eff.
  Eff (compiler :: COMPILER | eff) String

indexHandler :: forall eff.
  HandlerM (compiler :: COMPILER, express :: EXPRESS | eff) Unit
indexHandler = do
  indexHtml <- liftEff getIndexHtml
  send indexHtml

createApp :: forall eff. String -> Compiler -> App (compiler :: COMPILER | eff)
createApp publicPath compiler = do

  useExternal (morgan "dev")

  useExternal $ runFn2 devMiddleware compiler
    { publicPath
    , stats: { colors: true, chunks: false }
    , watchOptions: { aggregateTimeout: 500 } }

  get "*" indexHandler

main :: forall eff.
  ExpressM (console :: CONSOLE, config :: CONFIG, compiler :: COMPILER | eff) Server
main = do
  publicPath <- getPublicPath
  compiler <- getCompiler
  let app = createApp publicPath compiler
  listenHttp app 4000 \_ -> log $ "Webpack dev server listening at: 4000"
