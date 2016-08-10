module Todo.Components.NewTodo
  ( ViewProps
  , ComponentProps
  , newTodo ) where

import Prelude
import Control.Monad.Eff (Eff)
import React (ReactClass)
import React.Recompose (withHandlers, getContext)
import Signal.Channel (CHANNEL, send)
import Todo.State.Store (Action(TodosAction), TodoStore, storePropTypes)
import Todo.State.Todos (Action(Add))

foreign import component :: ReactClass ComponentProps

type ComponentProps = { addTodo :: String }
type HandlerProps = { addTodo :: String, store :: TodoStore }
type ViewProps = {}

addTodo :: forall eff. HandlerProps -> String ->
  Eff ( channel :: CHANNEL | eff ) Unit
addTodo props value = send props.store.actionChannel $ [TodosAction (Add value)]

newTodo :: ReactClass ViewProps
newTodo = context <<< handlers $ component
  where context = getContext storePropTypes
        handlers = withHandlers { addTodo }
