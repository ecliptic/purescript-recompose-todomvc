module Todo.State.Todos
  ( Action(..)
  , State(..)
  , Todo(..)
  , initialState
  , update
  ) where

import Prelude
import Data.Array ((:), filter)
import Data.Generic (class Generic, gShow)

type TodoRecord = { text :: String, id :: Int, completed :: Boolean }
newtype Todo = Todo { text :: String, id :: Int, completed :: Boolean }
derive instance eqTodo :: Eq Todo
derive instance genericTodo :: Generic Todo

newtype State = State { todos :: Array Todo, lastId :: Int }
derive instance eqState :: Eq State
derive instance genericState :: Generic State
instance showState :: Show State where show = gShow

data Action = Add String
  | Delete Int
  | Edit Int String
  | Complete Int Boolean
  | CompleteAll
  | ClearComplete

initialState :: State
initialState = State
  { todos: [ Todo { text: "Test", id: 0, completed: false } ], lastId: 0 }

updateAll :: (TodoRecord -> TodoRecord) -> Todo -> Todo
updateAll updateTodo = \(Todo todo) -> Todo $ updateTodo todo

updateWithId :: Int -> (TodoRecord -> TodoRecord) -> Todo -> Todo
updateWithId id updateTodo = \(Todo todo) ->
  if todo.id == id then Todo (updateTodo todo) else Todo todo

update :: Action -> State -> State
update (Add text) (State state) = State $
  let id = state.lastId + 1
  in state { todos = Todo { text, id, completed: false } : state.todos
           , lastId = id }

update (Delete id) (State state) = State $
  let delete = \(Todo todo) -> todo.id /= id
  in state { todos = filter delete state.todos }

update (Edit id text) (State state) = State $
  let updateTodo = \todo -> todo { text = text }
  in state { todos = updateWithId id updateTodo <$> state.todos }

update (Complete id isComplete) (State state) = State $
  let updateTodo = \todo -> todo { completed = isComplete }
  in state { todos = updateWithId id updateTodo <$> state.todos }

update CompleteAll (State state) = State $
  let updateTodo = \todo -> todo { completed = true }
  in state { todos = updateAll updateTodo <$> state.todos }

update ClearComplete (State state) = State $
  let clear = \(Todo todo) -> not todo.completed
  in state { todos = filter clear state.todos }
