module Todo.Components.Todos (todos) where

import React (ReactClass)
import Todo.State.Todos (Todo)
import Todo.Utils.Redux (connect)

foreign import component :: ReactClass
  { allCompleted :: Boolean, todos :: Array Todo }

todos :: ReactClass {}
todos = connectState component
  where mapStateToProps state =
          { allCompleted: state.todos.allCompleted
          , todos: state.todos.todos }
        actions = {}
        connectState = connect mapStateToProps actions
