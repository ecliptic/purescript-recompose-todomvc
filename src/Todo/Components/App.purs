module Todo.Components.App (ViewProps(..), view) where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import React (ReactClass, createClassStateless)
import Todo.State.Store (TodoStore)
import Todo.Utils.Recompose (mapProps)

foreign import component :: ReactClass ComponentProps

newtype ViewProps = ViewProps { store :: TodoStore }
newtype ComponentProps = ComponentProps
  { addTodo :: forall eff. Eff ( console :: CONSOLE | eff) Unit
  , store :: TodoStore }

toAppProps :: ViewProps -> ComponentProps
toAppProps (ViewProps props) = ComponentProps
  { addTodo: do log "new todo!", store: props.store }

view :: ReactClass ViewProps
view = createClassStateless $ mapProps toAppProps component
