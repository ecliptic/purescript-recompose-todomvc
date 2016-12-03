import {rootReducer} from '../State/Store'
import * as Redux from 'redux'
import persistState from 'redux-localstorage'

function devToolsEnhancer () {
  if (typeof window === 'object' && typeof window.devToolsExtension !== 'undefined') {
    return window.devToolsExtension()
  }
  return id => id
}

function persistStateEnhancer () {
  if (typeof window === 'object') {
    return persistState(undefined, {
      key: 'todos-purescript-recompose',
      slicer: paths => state => {
        // Censor the 'editing' state
        state.todos.todos = state.todos.todos.map(({id, title, completed}) => {
          return {id, title, completed}
        })
        return state
      },
    })
  }
  return id => id
}

export const createStore = initialState => {
  const enhancers = [persistStateEnhancer(), devToolsEnhancer()]

  const store = Redux.createStore(
    rootReducer,
    initialState,
    Redux.compose(...enhancers)
  )

  return store
}
