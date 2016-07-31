import React, {Component, PropTypes} from 'react'

export default class App extends Component {
  static childContextTypes = {
    store: PropTypes.object
  }

  getChildContext () {
    return {store: this.props.store}
  }

  render () {
    return (
      <h1>Coming soon: TodoMVC!</h1>
    )
  }
}

export const view = App
