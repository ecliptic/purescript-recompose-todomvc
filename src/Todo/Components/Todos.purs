module Todo.Components.Todos (todos) where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Array (null)
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

type HandleCompleteAll props eff =
  { completeAll :: Boolean -> Eff eff Unit
  , allCompleted :: Boolean | props } ->
  {} ->
  Eff eff Unit

foreign import view :: forall props eff.
  ReactClass (ViewProps props eff)

-- Props

toggleCompleteAll :: forall props eff. HandleCompleteAll props eff
toggleCompleteAll props event = props.completeAll (not props.allCompleted)

mapStateToProps :: { todos :: { todos :: Array Todo } } ->
  { allCompleted :: Boolean, todos :: Array Todo, empty :: Boolean }
mapStateToProps state =
  { allCompleted: all mapCompleted state.todos.todos
  , todos: state.todos.todos
  , empty: null state.todos.todos }

-- Component

todos :: ReactClass {}
todos = connectState <<< handleCompleteAll $ view
  where connectState = connect mapStateToProps $ { completeAll: completeAll }
        handleCompleteAll = withHandlers { toggleCompleteAll }
