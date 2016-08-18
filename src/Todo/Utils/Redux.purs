module Todo.Utils.Redux
  ( Action
  , Reducer
  , ReduxReducer
  , Store
  , STORE
  , applyReducer
  , createReducer
  , createAction
  , combineReducers
  , provider
  , connect
  ) where

import Prelude
import Data.Function.Uncurried (Fn2, mkFn2)
import Data.Maybe (Maybe(Just))
import Data.Nullable (toMaybe, Nullable)
import React (ReactClass)

foreign import data Store :: *
foreign import data STORE :: !

newtype Action action = Action { type :: String, pureType :: action }

-- | The simple PureScript reducer
type Reducer action state = action -> state -> state

-- | A reducer wrapped for use with Redux
newtype ReduxReducer action state =
  ReduxReducer (Fn2 (Nullable state) (Action action) state)

foreign import applyReducer :: forall action state.
  Reducer action state -> action -> state -> state

-- | Construct a Redux reducer, which wraps the underlying action in an Action
-- | newtype that gives it a "type" property when used in JavaScript FFI
createReducer :: forall action state.
  Reducer action state -> state -> ReduxReducer action state
createReducer reducer initialState = ReduxReducer <<< mkFn2 $
  \state (Action action) ->
    case (toMaybe state) of
      (Just s) -> applyReducer reducer action.pureType s
      otherwise -> initialState

-- | Transform the action's type to a string for Redux
foreign import typeToString :: forall action. action -> String

-- | Construct a pure Redux action
createAction :: forall action. action -> Action action
createAction action = Action
  { type: typeToString action, pureType: action }

-- | Easily combine reducers using the underlying Redux utility
foreign import combineReducers :: forall reducers action state.
  Record reducers -> ReduxReducer action state

-- | The <Provider/> component from react-redux
foreign import provider :: ReactClass { store :: Store }

-- | The connect wrapper from react-redux.
-- | *NOTE*: The mergeProps and options arguments are not yet supported.
foreign import connect :: forall state actions ownerProps props.
  (state -> props) -> actions -> ReactClass props -> ReactClass ownerProps
