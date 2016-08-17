module Todo.Components.NewTodo (newTodo) where

import Prelude
import Control.Monad.Eff (Eff)
import React (ReactClass)
import React.Recompose (EventHandler, withHandlers)
import Todo.State.Todos (add) as Actions
import Todo.Utils.Redux (connect)

type AddDispatch eff = String -> Eff eff Unit
type Event event = { target :: { value :: String } | event}

foreign import component :: forall props event eff. ReactClass
  { addTodo :: EventHandler props event eff
  , add :: AddDispatch eff }

addTodo :: forall props event eff.
  EventHandler { add :: AddDispatch eff | props } (Event event) eff
addTodo props event = props.add event.target.value

newTodo :: ReactClass {}
newTodo = connectState <<< handlers $ component
  where mapStateToProps = (\_ -> {})
        actions = { add: Actions.add }
        connectState = connect mapStateToProps actions
        handlers = withHandlers { addTodo }
