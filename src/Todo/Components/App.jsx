import Controls from 'Todo/Components/Controls'
import Footer from 'Todo/Components/Footer'
import NewTodo from 'Todo/Components/NewTodo'
import React, {Component, PropTypes} from 'react'
import Todos from 'Todo/Components/Todos'

import 'todomvc-common/base.css'
import 'todomvc-app-css/index.css'

export default class App extends Component {
  static childContextTypes = {
    store: PropTypes.object
  }

  getChildContext () {
    return {store: this.props.store}
  }

  render () {
    return (
      <div>
        <section className="todoapp">
          <NewTodo />
          <Todos />
          <Controls />
        </section>
        <Footer />
      </div>
    )
  }
}

export const view = App
