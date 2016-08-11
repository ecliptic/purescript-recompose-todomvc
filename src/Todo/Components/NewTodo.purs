module Todo.Components.NewTodo ( ViewProps, ComponentProps, newTodo ) where

import Prelude
import React (ReactClass)
import React.Recompose (withHandlers)
import Signal.Channel (send)
import Todo.State.Store (Action(TodosAction), EventHandler, storeContext)
import Todo.State.Todos (Action(Add))

type ComponentProps = { addTodo :: EventHandler String }
type ViewProps = {}

foreign import component :: ReactClass ComponentProps

addTodo :: EventHandler String
addTodo props value = send props.store.actionChannel [TodosAction (Add value)]

newTodo :: ReactClass ViewProps
newTodo = storeContext <<< handlers $ component
  where handlers = withHandlers { addTodo }
