import * as Redux from 'redux'
import {Provider, connect} from 'react-redux'
import storeShape from 'react-redux/lib/utils/storeShape'

export const applyReducer = reducer => action => state => {
  try {
    state = reducer(action)(state)
  } catch (e) {
    if (!e.message.startsWith('Failed pattern match')) throw e
  }
  return state
}

exports.combineReducers = Redux.combineReducers

export function actionTransformer (action) {
  if (typeof action.type === 'object') {
    let type = action.type.constructor.name
    let values = {}

    for (let prop in action.type) {
      if (/^value\d+$/.test(prop)) {
        let value = action.type[prop]
        values[prop] = value
        type += ' '
        type += typeof value === 'object' ? '...' : JSON.stringify(value)
      }
    }

    return {...values, ...action, type}
  }
  return action
}

exports.storeShape = storeShape

exports.provider = Provider

exports.connect = mapStateToProps => mapDispatchToProps => {
  return connect(mapStateToProps, mapDispatchToProps)
}
