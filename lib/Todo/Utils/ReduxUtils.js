import * as Redux from 'redux'
import {Provider, connect} from 'react-redux'

export const applyReducer = reducer => action => state => {
  return reducer(action)(state)
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

exports.provider = Provider

exports.connect = mapStateToProps => mapDispatchToProps => {
  return connect(mapStateToProps, mapDispatchToProps)
}

exports.typeToString = action => {
  if (typeof action === 'string') return action

  const name = action.constructor.name

  const values = Object.keys(action).map(prop => {
    if (prop.startsWith('value')) {
      const value = action[prop]

      if (typeof value === 'object') {
        return '[object]'
      }

      return JSON.stringify(value)
    }
  })

  return `${name} ${values.join(' ')}`
}
