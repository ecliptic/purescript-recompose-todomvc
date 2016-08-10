module Todo.Components.App (app) where

import Prelude
import React (ReactClass)
import React.Recompose (withContext, mapProps)
import Todo.State.Store (TodoStore, storePropTypes)

foreign import component :: ReactClass {}

app :: ReactClass { store :: TodoStore }
app = context <<< props $ component
  where props = mapProps \_ -> {}
        context = withContext storePropTypes \p -> { store: p.store }
