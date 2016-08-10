module Todo.Components.NewTodo
  ( ViewProps
  , ComponentProps
  , newTodo ) where

import Prelude
import React (ReactClass)
import React.Recompose (withHandlers, getContext)
import Signal.Channel (send)
import Todo.State.Store (Action(TodosAction), EventHandler, storePropTypes)
import Todo.State.Todos (Action(Add))

type ComponentProps = { addTodo :: EventHandler String }

type ViewProps = {}

foreign import component :: ReactClass ComponentProps

addTodo :: EventHandler String
addTodo props value = send props.store.actionChannel action
  where action = [TodosAction (Add value)]

newTodo :: ReactClass ViewProps
newTodo = context <<< handlers $ component
  where context = getContext storePropTypes
        handlers = withHandlers { addTodo }
