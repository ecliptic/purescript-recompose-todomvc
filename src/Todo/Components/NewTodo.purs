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

type EventHandler value = HandlerProps -> value -> Eff ( channel :: CHANNEL | eff ) Unit
type ComponentProps = { addTodo :: EventHandler }
type HandlerProps = { addTodo :: EventHandler, store :: TodoStore }
type ViewProps = {}

addTodo :: EventHandler String
addTodo props value = send props.store.actionChannel $ [TodosAction (Add value)]

newTodo :: ReactClass ViewProps
newTodo = context <<< handlers $ component
  where context = getContext storePropTypes
        handlers = withHandlers { addTodo }
