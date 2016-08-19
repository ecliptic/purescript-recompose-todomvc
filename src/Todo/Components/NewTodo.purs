module Todo.Components.NewTodo (newTodo) where

import Prelude
import Control.Monad.Eff (Eff)
import React (ReactClass)
import React.Recompose (EventHandler, withHandlers)
import Todo.State.Todos (add) as Todos
import Todo.Utils.Redux (connect)

foreign import component :: forall props eff. ReactClass
  { add :: String -> Eff eff Unit
  , addTodo :: HandleAdd props eff
  , nextId :: String }

type HandleAdd props eff = EventHandler
  { add :: String -> Eff eff Unit | props }
  { key :: String, target :: { value :: String } }
  eff

addTodo :: forall props eff. HandleAdd props eff
addTodo props event = case event.key of
  "Enter" -> props.add event.target.value
  _ -> pure unit

newTodo :: ReactClass {}
newTodo = connectState <<< handlers $ component
  where mapStateToProps = \state -> { nextId: show $ state.todos.lastId + 1 }
        dispatchActions = { add: Todos.add }
        connectState = connect mapStateToProps dispatchActions
        handlers = withHandlers { addTodo }
