module Todo.Utils.Recompose (mapProps) where

import Prelude
import React (createFactory, ReactElement, ReactClass)

-- | Create a factory that generates an instance of the given component with
-- | props transformed by the propMapper function.
mapProps :: forall fromProps toProps.
  (fromProps -> toProps) ->
  ReactClass toProps ->
  fromProps -> ReactElement
mapProps propMapper wrappedComponent =
  \props -> componentFactory $ propMapper props
  where componentFactory = createFactory wrappedComponent
