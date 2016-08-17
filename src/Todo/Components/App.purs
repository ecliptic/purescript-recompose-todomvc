module Todo.Components.App (app) where

import Prelude
import React (ReactClass)
import React.Recompose (mapProps, withContext)
import Todo.Utils.Redux (Store, storeShape)

foreign import component :: ReactClass {}

app :: ReactClass { store :: Store }
app = withStoreContext <<< withoutProps $ component
  where withStoreContext = withContext storeShape (\props -> props.store)
        withoutProps = mapProps \_ -> {}
