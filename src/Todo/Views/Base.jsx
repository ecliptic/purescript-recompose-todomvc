import {createStore} from 'Todo/State/Init'
import {initialState} from 'Todo/State/Store'
import {Provider} from 'react-redux'
import {safeStringify} from 'Todo/Utils/String'
import React, {Component} from 'react'

export default class Base extends Component {

  static defaultProps = {
    initialState,
  }

  constructor (...args) {
    super(...args)
    if (window && window.__INITIAL_STATE__) {
      // If we're resuming in the browser, use the initial state attached to the
      // window.
      this.store = createStore(JSON.parse(window.__INITIAL_STATE__))()
    } else {
      // If we're rendering this file during the server build, use the default
      // initialState that comes from the props.
      this.store = createStore(this.props.initialState)()
    }
  }

  render () {
    const initialStateString = safeStringify(initialState)
    return (
      <Provider store={this.store}>
        <div>
          {this.props.children}
          <script>
            window.__INITIAL_STATE__ = '{initialStateString}'
          </script>
        </div>
      </Provider>
    )
  }

}
