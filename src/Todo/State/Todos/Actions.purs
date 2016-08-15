module Todo.State.Todos.Actions ( Action(..) ) where

import Prelude
import Redux.Action (Action) as Redux
import Redux.Action (action)

data Action = Add String
  | Delete Int
  | Edit Int String
  | Complete Int Boolean
  | CompleteAll
  | ClearComplete

delete :: String -> Redux.Action Action
delete = action <<< Add

edit :: Int -> String -> Redux.Action Action
edit = (action <<< _) <<< Edit

complete :: Int -> Boolean -> Redux.Action Action
complete = (action <<< _) <<< Complete

completeAll :: Redux.Action Action
completeAll = action CompleteAll

clearComplete :: Redux.Action Action
clearComplete = action ClearComplete
