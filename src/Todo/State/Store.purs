module Todo.State.Store where

import Prelude
import Control.Monad.Eff (Eff)
import Manifold (Store, StoreEffects, runStore)
import Todo.State.Todos (Action, State, initialState, update) as Todos

data Action = TodosAction (Todos.Action)

newtype State = State
  { todos :: Todos.State }

initialState :: State
initialState = State { todos: Todos.initialState }

update :: Action -> State -> State
update (TodosAction action) (State state) = State $
  state { todos = Todos.update action state.todos }

createStore :: forall eff. Eff (StoreEffects eff) (Store Action eff State)
createStore = runStore update initialState
