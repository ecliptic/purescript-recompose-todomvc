import * as Redux from 'redux'
import persistState from 'redux-localstorage'

const devToolsEnhancer = (typeof window === 'object' && typeof window.devToolsExtension !== 'undefined')
  ? window.devToolsExtension()
  : id => id

export const createStore = initialState => () => {
  // Import this inside the function to avoid a circular dependency
  const rootReducer = require('Todo/State/Store.purs').rootReducer

  const enhancers = [
    persistState(undefined, {
      key: 'todos-purescript-recompose',
      slicer: paths => state => {
        // Censor the 'editing' state
        state.todos.todos = state.todos.todos.map(({id, title, completed}) => {
          return {id, title, completed}
        })
        return state
      },
    }),
    devToolsEnhancer,
  ]

  const store = Redux.createStore(
    rootReducer,
    initialState,
    Redux.compose(...enhancers)
  )

  return store
}
