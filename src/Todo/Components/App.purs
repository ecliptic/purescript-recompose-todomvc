module Todo.Components.App (view) where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import React (ReactClass, createClassStateless)
import Todo.State.Store (TodoStore)
import Todo.Utils.Recompose (mapProps)

foreign import app :: forall props. ReactClass props

type InputProps = { store :: TodoStore }

type OutputProps = forall eff.
  { store :: TodoStore
  , addTodo :: Eff ( console :: CONSOLE | eff) Unit }

toAppProps :: InputProps -> OutputProps
toAppProps props = { addTodo: addTodo, store: props.store }
  where addTodo = do log "new todo!"

view :: ReactClass InputProps
view = createClassStateless $ mapProps toAppProps app
