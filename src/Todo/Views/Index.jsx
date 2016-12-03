import {createStore} from '../State/Create'
import {initialState} from '../State/Store'
import {Provider} from 'react-redux'
import App from './App'
import React from 'react'
import ReactDOM from 'react-dom'

const store = createStore(initialState)

ReactDOM.render(
  <Provider store={store}>
    <App />
  </Provider>,
  document.getElementById('app')
)
