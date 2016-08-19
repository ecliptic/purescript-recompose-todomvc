module Todo.Components.Controls (controls) where

import Prelude
import Control.Monad.Eff (Eff)
import DOM (DOM)
import DOM.Event.Event (preventDefault, Event)
import Data.Array (length)
import React (ReactClass)
import React.Recompose (mapProps, withHandlers, withState')
import Todo.State.Todos (Todo(Todo), lengthCompleted)
import Todo.Utils.Redux (connect)

-- View

type ViewProps eff =
  { remaining :: String
  , hidden :: Boolean
  , showClear :: Boolean
  , filterAll :: FilterHandler eff
  , filterActive :: FilterHandler eff
  , filterCompleted :: FilterHandler eff }

type FilterHandler eff =
  { setFilter :: (Todo -> Boolean) -> Eff (dom :: DOM | eff) Unit } ->
  Event -> Eff (dom :: DOM | eff) Unit

foreign import view :: forall eff. ReactClass (ViewProps eff)

-- Props

mapStateToProps :: forall props.
  { todos :: { todos :: Array Todo } | props } -> { todos :: Array Todo }
mapStateToProps state = { todos: state.todos.todos }

mapControlProps :: forall props.
  { todos :: Array Todo | props } ->
  { remaining :: String
  , hidden :: Boolean
  , showClear :: Boolean }
mapControlProps props =
  let
    count = length props.todos
    complete = lengthCompleted props.todos
    remaining = count - complete
    label = if remaining == 1 then " item left" else " items left"
  in
    { remaining: show remaining <> label
    , hidden: remaining < 1
    , showClear: complete > 0 }

-- Filters

all :: Todo -> Boolean
all = const true

active :: Todo -> Boolean
active (Todo todo) = not todo.completed

completed :: Todo -> Boolean
completed (Todo todo) = todo.completed

filterAction :: forall eff. (Todo -> Boolean) -> FilterHandler eff
filterAction filterBy props event = do
  preventDefault event
  props.setFilter filterBy

-- Component

controls :: ReactClass {}
controls = connectState <<< filterState <<< controlProps <<< eventHandlers $ view
  where dispatchActions = {}
        connectState = connect mapStateToProps dispatchActions
        filterState = withState' "filterBy" "setFilter" all
        controlProps = mapProps mapControlProps
        eventHandlers = withHandlers
          { filterAll: filterAction all
          , filterActive: filterAction active
          , filterCompleted: filterAction completed }
