module Todo.Components.NewTodo
  ( ViewProps(..)
  , ComponentProps(..)
  , newTodo ) where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import React (ReactClass)
import React.Recompose (withHandlers, getContext)
import Todo.State.Store (storePropTypes)
import Todo.State.Todos (Action(Add))

foreign import component :: forall eff. ReactClass (ComponentProps eff)

type ComponentProps eff = { addTodo :: Eff (console :: CONSOLE | eff) Unit }
type ViewProps = {}

newTodo :: ReactClass ViewProps
newTodo = handlers $ component
  where -- context = getContext storePropTypes
        addTodo props value = do log $ "Add: " <> value
        handlers = withHandlers { addTodo }
