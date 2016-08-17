import * as Redux from 'redux'

const devToolsEnhancer = (typeof window === 'object' && typeof window.devToolsExtension !== 'undefined')
  ? window.devToolsExtension()
  : id => id

export const createStore = initialState => () => {
  // Import this inside the function to avoid a circular dependency
  const rootReducer = require('Todo/State/Store.purs').rootReducer

  const enhancers = [devToolsEnhancer]

  const store = Redux.createStore(
    rootReducer,
    initialState,
    Redux.compose(...enhancers)
  )

  return store
}
