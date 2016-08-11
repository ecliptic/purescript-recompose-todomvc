module Todo.Components.App (app) where

import Prelude
import React (ReactClass)
import React.Recompose (mapProps)
import Todo.State.Store (TodoStore, withStoreContext)

foreign import component :: ReactClass {}

app :: ReactClass { store :: TodoStore }
app = withStoreContext <<< dropStoreProp $ component
  where dropStoreProp = mapProps \_ -> {}
