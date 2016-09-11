module Todo.Components.Todo (todo) where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Function.Uncurried (Fn2, runFn2)
import React (ReactClass)
import React.Recompose (withHandlers)
import Todo.State.Todos (Id, TodoRecord, complete, edit, update)
import Redux.Mini (connect)

-- View

type ViewProps props eff =
  { todo :: TodoRecord
  , toggle :: HandleToggle props eff
  , editTodo :: HandleEdit props eff
  , updateTodo :: HandleUpdate props eff }

foreign import view :: forall props eff. ReactClass (ViewProps props eff)

-- Props

type HandleToggle props eff =
  { complete :: Id -> Boolean -> Eff eff Unit, todo :: TodoRecord | props } ->
  {} -> Eff eff Unit

toggle :: forall props eff. HandleToggle props eff
toggle props event = props.complete props.todo.id completed
  where completed = not props.todo.completed

type HandleEdit props eff =
  { edit :: Id -> Eff eff Unit, todo :: TodoRecord | props } ->
  {} -> Eff eff Unit

editTodo :: forall props eff. HandleEdit props eff
editTodo props event = props.edit props.todo.id

type HandleUpdate props eff =
  { update :: Fn2 Id String (Eff eff Unit), todo :: TodoRecord | props } ->
  { target :: { value :: String } } -> Eff eff Unit

updateTodo :: forall props eff. HandleUpdate props eff
updateTodo props event = runFn2 props.update props.todo.id event.target.value

-- Component

todo :: ReactClass { todo :: TodoRecord }
todo = connectState <<< withHandlers handlers $ view
  where handlers = { toggle, editTodo, updateTodo }
        actions = { complete, edit, update }
        connectState = connect (\_ -> {}) actions
