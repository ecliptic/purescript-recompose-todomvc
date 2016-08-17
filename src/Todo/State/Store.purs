module Todo.State.Store (createStore, rootReducer, initialState) where

import Control.Monad.Eff (Eff)
import Todo.State.Todos (State, initialState, reducer) as Todos
import Todo.Utils.Redux (Store, STORE, ReduxReducer, combineReducers)

foreign import createStore :: forall state eff.
  state -> Eff (store :: STORE | eff) Store

rootReducer :: forall action state. ReduxReducer action state
rootReducer = combineReducers { todos: Todos.reducer }

initialState :: { todos :: Todos.State }
initialState = { todos: Todos.initialState }
