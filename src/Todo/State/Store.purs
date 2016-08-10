module Todo.State.Store
  ( Action(..)
  , State
  , TodoEffects
  , TodoStore
  , ReactPropType
  , storePropTypes
  , initialState
  , update
  , createStore
  ) where

import Prelude
import Control.Monad.Eff (Eff)
import DOM (DOM)
import Manifold (Store, StoreEffects, runStore)
import Todo.State.Todos (Action, State, initialState, update) as Todos

data Action = TodosAction Todos.Action

newtype State = State { todos :: Todos.State }

type TodoEffects = StoreEffects (dom :: DOM)
type TodoStore = Store Action TodoEffects State

foreign import data ReactPropType :: *
foreign import storePropType :: ReactPropType

storePropTypes :: { store :: ReactPropType }
storePropTypes = { store: storePropType }

initialState :: State
initialState = State { todos: Todos.initialState }

update :: Action -> State -> State
update (TodosAction action) (State state) = State $
  state { todos = Todos.update action state.todos }

createStore :: Eff TodoEffects (Store Action TodoEffects State)
createStore = runStore update initialState
