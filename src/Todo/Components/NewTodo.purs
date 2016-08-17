module Todo.Components.NewTodo (newTodo) where

import Prelude
import Control.Monad.Eff (Eff)
import React (ReactClass)
import React.Recompose (EventHandler, withHandlers)
import Todo.State.Todos (add) as Actions
import Todo.Utils.Redux (connect)

type AddDispatch eff = String -> Eff eff Unit

foreign import component :: forall props event eff. ReactClass
  { addTodo :: EventHandler props event eff
  , add :: AddDispatch eff }

addTodo :: forall props eff.
  EventHandler { add :: AddDispatch eff | props } String eff
addTodo props text = props.add text

newTodo :: ReactClass {}
newTodo = connectState <<< handlers $ component
  where mapStateToProps = (\_ -> {})
        actions = { add: Actions.add }
        connectState = connect mapStateToProps actions
        handlers = withHandlers { addTodo }
