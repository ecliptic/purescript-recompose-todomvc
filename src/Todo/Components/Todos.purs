module Todo.Components.Todos (todos) where

import Prelude
import React (ReactClass)
import React.Recompose (mapProps)
import Todo.State.Store (storeContext)
import Todo.State.Todos (Todo(Todo))

type ComponentProps = { allCompleted :: Boolean, todos :: Array Todo }
type ViewProps = {}

foreign import component :: ReactClass ComponentProps

todos :: ReactClass ViewProps
todos = storeContext <<< viewModel $ component
  where viewModel = mapProps \props ->
                      { allCompleted: false
                      , todos: [ Todo
                        { text: "Hi!", id: 0, completed: false } ] }
