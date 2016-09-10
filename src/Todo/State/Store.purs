module Todo.State.Store (rootReducer, initialState) where

import Control.Monad.Eff (Eff)
import Todo.State.Todos (State, initialState, reducer) as Todos
import Todo.Utils.Redux (Store, STORE, ReduxReducer, combineReducers)

rootReducer :: forall action state. ReduxReducer action state
rootReducer = combineReducers { todos: Todos.reducer }

initialState :: { todos :: Todos.State }
initialState = { todos: Todos.initialState }
