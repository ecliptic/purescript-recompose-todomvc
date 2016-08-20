module Todo.Components.Todo (todo) where

import Prelude
import Control.Monad.Eff (Eff)
import React (ReactClass)
import React.Recompose (withHandlers)
import Todo.State.Todos (Id, TodoRecord, complete)
import Todo.Utils.Redux (connect)

-- View

type ViewProps props eff =
  { todo :: TodoRecord
  , toggle :: HandleToggle props eff}

type HandleToggle props eff =
  { complete :: Id -> Boolean -> Eff eff Unit
  , todo :: TodoRecord | props } ->
  {} ->
  Eff eff Unit

foreign import view :: forall props eff. ReactClass (ViewProps props eff)

-- Props

toggle :: forall props eff. HandleToggle props eff
toggle props event = props.complete props.todo.id completed
  where completed = not props.todo.completed

-- Component

todo :: ReactClass { todo :: TodoRecord }
todo = connectState <<< withHandlers { toggle } $ view
  where connectState = connect (\_ -> {}) { complete }
