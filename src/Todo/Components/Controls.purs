module Todo.Components.Controls (controls) where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Array (length)
import React (ReactClass)
import React.Recompose (EventHandler, mapProps)
import Todo.State.Todos (Todo(Todo), lengthCompleted)
import Todo.Utils.Redux (connect)

foreign import component :: forall props eff. ComponentProps props eff

type ComponentProps props eff = ReactClass
  { remaining :: String
  , hidden :: Boolean
  , showClear :: Boolean
  , filterAll :: HandleFilter props eff
  , filterActive :: HandleFilter props eff
  , filterCompleted :: HandleFilter props eff
  , clearCompleted :: HandleFilter props eff }

type HandleFilter props eff = EventHandler
  { completeAll :: Boolean -> Eff eff Unit
  , allCompleted :: Boolean | props }
  {}
  eff

mapStateToProps :: forall props.
  { todos :: { todos :: Array Todo } | props } -> { todos :: Array Todo }
mapStateToProps = \state -> { todos: state.todos.todos }

controls :: ReactClass {}
controls = connectState <<< controlProps $ component
  where dispatchActions = {}
        connectState = connect mapStateToProps dispatchActions
        controlProps = mapProps \props ->
          let count = length props.todos
              completed = lengthCompleted props.todos
              remaining = count - completed
              label = if remaining == 1 then " item left" else " items left"
              showClear = completed > 0
          in { remaining: show remaining <> label
             , hidden: remaining < 1
             , showClear }
