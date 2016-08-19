module Todo.Components.NewTodo (newTodo) where

import Prelude
import Control.Monad.Eff (Eff)
import React (ReactClass)
import React.Recompose (withHandlers)
import Todo.State.Todos (add) as Todos
import Todo.Utils.Redux (connect)

-- View

foreign import view :: forall props eff. ReactClass
  { add :: String -> Eff eff Unit
  , addTodo :: HandleAdd props eff
  , nextId :: String }

-- Props

type HandleAdd props eff =
  { add :: String -> Eff eff Unit | props } ->
  { key :: String, target :: { value :: String } } ->
  Eff eff Unit

addTodo :: forall props eff. HandleAdd props eff
addTodo props event = case event.key of
  "Enter" -> props.add event.target.value
  _ -> pure unit

-- Component

newTodo :: ReactClass {}
newTodo = connectState <<< eventHandlers $ view
  where mapStateToProps = \state -> { nextId: show $ state.todos.lastId + 1 }
        dispatchActions = { add: Todos.add }
        connectState = connect mapStateToProps dispatchActions
        eventHandlers = withHandlers { addTodo }
