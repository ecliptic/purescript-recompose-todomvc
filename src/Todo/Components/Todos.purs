module Todo.Components.Todos (todos) where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Foldable (all)
import React (ReactClass)
import React.Recompose (withHandlers, EventHandler)
import Todo.State.Todos (Todo(Todo), completeAll)
import Todo.Utils.Redux (connect)

foreign import component :: forall props eff.
  ReactClass (ComponentProps props eff)

type ComponentProps props eff =
  { allCompleted :: Boolean
  , todos :: Array Todo
  , toggleCompleteAll :: HandleCompleteAll props eff }

type HandleCompleteAll props eff = EventHandler
  { completeAll :: Boolean -> Eff eff Unit
  , allCompleted :: Boolean | props }
  {}
  eff

toggleCompleteAll :: forall props eff. HandleCompleteAll props eff
toggleCompleteAll props event = props.completeAll (not props.allCompleted)

mapStateToProps :: { todos :: { todos :: Array Todo } } ->
  { allCompleted :: Boolean, todos :: Array Todo }
mapStateToProps state =
  let completed (Todo todo) = todo.completed
  in  { allCompleted: all completed state.todos.todos
      , todos: state.todos.todos }

todos :: ReactClass {}
todos = connectState <<< handleCompleteAll $ component
  where actions = { completeAll: completeAll }
        connectState = connect mapStateToProps actions
        handleCompleteAll = withHandlers { toggleCompleteAll }
