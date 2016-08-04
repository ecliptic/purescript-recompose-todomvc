module Todo.Components.App (component) where

import Prelude
import React (ReactElement, ReactClass, createElement, createClassStateless)

foreign import component :: forall props. ReactClass props

mapProps :: forall oldProps newProps.
  (oldProps -> newProps) ->
  ReactClass newProps ->
  (newProps -> ReactElement) ->
  ReactClass newProps
mapProps propMapper component = createClassStateless $
  \props -> createElement component (propMapper props)

-- view :: forall props. ReactClass props
-- view =
