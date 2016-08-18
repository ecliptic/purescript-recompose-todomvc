module Todo.Components.Controls (controls) where

import Prelude
import Data.Array (filter, length)
import React (ReactClass)
import React.Recompose (mapProps)
import Todo.Utils.Redux (connect)

foreign import component :: ReactClass
  { remaining :: String, hidden :: Boolean, showClear :: Boolean }

controls :: ReactClass {}
controls = connectState <<< controlProps $ component
  where mapStateToProps = \state -> { todos: state.todos.todos }
        dispatchActions = {}
        connectState = connect mapStateToProps dispatchActions
        controlProps = mapProps \props ->
          let count = length props.todos
              completed = length $ filter _.completed props.todos
              remaining = count - completed
              label = if remaining == 1 then " item left" else " items left"
              showClear = completed > 0
          in { remaining: show remaining <> label
             , hidden: remaining < 1
             , showClear }
