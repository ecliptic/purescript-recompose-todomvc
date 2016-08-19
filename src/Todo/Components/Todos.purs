module Todo.Components.Todos (todos) where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Foldable (all)
import React (ReactClass)
import React.Recompose (withHandlers)
import Todo.State.Todos (Todo, completeAll, mapCompleted)
import Todo.Utils.Redux (connect)

-- View

type ViewProps props eff =
  { allCompleted :: Boolean
  , todos :: Array Todo
  , toggleCompleteAll :: HandleCompleteAll props eff }

foreign import view :: forall props eff.
  ReactClass (ViewProps props eff)

-- Props

type HandleCompleteAll props eff =
  { completeAll :: Boolean -> Eff eff Unit
  , allCompleted :: Boolean | props } ->
  {} ->
  Eff eff Unit

toggleCompleteAll :: forall props eff. HandleCompleteAll props eff
toggleCompleteAll props event = props.completeAll (not props.allCompleted)

mapStateToProps :: { todos :: { todos :: Array Todo } } ->
  { allCompleted :: Boolean, todos :: Array Todo }
mapStateToProps state =
  { allCompleted: all mapCompleted state.todos.todos
  , todos: state.todos.todos }

-- Component

todos :: ReactClass {}
todos = connectState <<< handleCompleteAll $ view
  where actions = { completeAll: completeAll }
        connectState = connect mapStateToProps actions
        handleCompleteAll = withHandlers { toggleCompleteAll }
