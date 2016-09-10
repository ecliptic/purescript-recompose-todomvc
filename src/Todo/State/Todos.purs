module Todo.State.Todos
  ( Action(..)
  , Id
  , State(State)
  , Text
  , TodoRecord
  , Todo(Todo)
  , add
  , clearComplete
  , complete
  , completeAll
  , delete
  , edit
  , initialState
  , reducer
  , mapCompleted
  , lengthCompleted
  , update
  ) where

import Prelude
import Data.Array (length, (:), filter)
import Data.Function.Uncurried (mkFn0, Fn0, mkFn2, Fn2)
import Data.Generic (class Generic, gShow)
import Debug.Trace (traceAny)
import Todo.Utils.Redux (Action) as Redux
import Todo.Utils.Redux (Reducer, ReduxReducer, createAction, createReducer)

type TodoRecord =
  { text :: String
  , id :: Int
  , completed :: Boolean
  , editing :: Boolean }

newtype Todo = Todo
  { text :: String
  , id :: Int
  , completed :: Boolean
  , editing :: Boolean }
derive instance eqTodo :: Eq Todo
derive instance genericTodo :: Generic Todo

newtype State = State { todos :: Array Todo, lastId :: Int }
derive instance eqState :: Eq State
derive instance genericState :: Generic State
instance showState :: Show State where show = gShow

-- Actions ---------------------------------------------------------------------

type Text = String
type Id = Int

data Action = Add Text
  | Delete Id
  | Edit Id
  | Update Id String
  | Complete Id Boolean
  | CompleteAll Boolean
  | ClearComplete
  | Else -- Represents external actions

add :: Text -> Redux.Action Action
add text = createAction $ Add text

delete :: Id -> Redux.Action Action
delete id = createAction $ Delete id

edit :: Id -> Redux.Action Action
edit id = createAction $ Edit id

update :: Fn2 Id String (Redux.Action Action)
update = mkFn2 action
  where action id text = createAction $ Update id text

complete :: Fn2 Id Boolean (Redux.Action Action)
complete = mkFn2 action
  where action id isCompleted = createAction $
          Complete (traceAny id \_ -> id) isCompleted

completeAll :: Boolean -> Redux.Action Action
completeAll isCompleted = createAction $ CompleteAll isCompleted

clearComplete :: Fn0 (Redux.Action Action)
clearComplete = mkFn0 action
  where action _ = createAction ClearComplete

-- Reducer ---------------------------------------------------------------------

initialState :: State
initialState = State { todos: [], lastId: 0 }

todosReducer :: Reducer Action State
todosReducer (Add text) (State state) = State $
  let id = state.lastId + 1
      todo = { text, id, completed: false, editing: false }
  in state { todos = Todo todo : state.todos
           , lastId = id }

todosReducer (Delete id) (State state) = State $
  let del (Todo todo) = todo.id /= id
  in state { todos = filter del state.todos }

todosReducer (Edit id) (State state) = State $
  let editTodo todo = todo { editing = true }
  in state { todos = updateWithId id editTodo <$> state.todos }

todosReducer (Update id text) (State state) = State $
  let updateTodo todo = todo { text = text, editing = false }
  in state { todos = updateWithId id updateTodo <$> state.todos }

todosReducer (Complete id isComplete) (State state) = State $
  let updateTodo todo = todo { completed = isComplete }
  in state { todos = updateWithId id updateTodo <$> state.todos }

todosReducer (CompleteAll isCompleted) (State state) = State $
  let updateTodo todo = todo { completed = isCompleted }
  in state { todos = updateAll updateTodo <$> state.todos }

todosReducer ClearComplete (State state) = State $
  let clear (Todo todo) = not todo.completed
  in state { todos = filter clear state.todos }

todosReducer _ state = state

reducer :: ReduxReducer Action State
reducer = createReducer todosReducer initialState

-- Utils -----------------------------------------------------------------------

updateAll :: (TodoRecord -> TodoRecord) -> Todo -> Todo
updateAll updateTodo = \(Todo todo) -> Todo $ updateTodo todo

updateWithId :: Int -> (TodoRecord -> TodoRecord) -> Todo -> Todo
updateWithId id updateTodo = \(Todo todo) ->
  if todo.id == id then Todo (updateTodo todo) else Todo todo

mapCompleted :: Todo -> Boolean
mapCompleted (Todo todo) = todo.completed

lengthCompleted :: Array Todo -> Int
lengthCompleted todos = length $ filter mapCompleted todos
