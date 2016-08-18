module Todo.Components.NewTodo (newTodo) where

import Prelude
import Control.Monad.Eff (Eff)
import React (ReactClass)
import React.Recompose (EventHandler, withHandlers)
import Todo.State.Todos (add) as Todos
import Todo.Utils.Redux (connect)

type KeyEvent = { key :: String, target :: { value :: String } }

type DispatchAdd eff = String -> Eff eff Unit

foreign import component :: forall props event eff. ReactClass
  -- The "Add" action is exposed here, and is used by addTodo below
  { add :: DispatchAdd eff
  -- The event handler takes care of the DOM event
  , addTodo :: EventHandler props event eff
  -- The nextId becomes the <input> key so that it clears on adding new items
  , nextId :: String }

addTodo :: forall props eff.
  EventHandler { add :: DispatchAdd eff | props } KeyEvent eff
addTodo props event = case event.key of
  "Enter" -> props.add event.target.value
  _ -> pure unit

newTodo :: ReactClass {}
newTodo = connectState <<< handlers $ component
  where mapStateToProps = \state -> { nextId: show $ state.todos.lastId + 1 }
        dispatchActions = { add: Todos.add }
        connectState = connect mapStateToProps dispatchActions
        handlers = withHandlers { addTodo }
