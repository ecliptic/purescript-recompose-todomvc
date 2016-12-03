import {controls as Controls} from '../Components/Controls.purs'
import {newTodo as NewTodo} from '../Components/NewTodo.purs'
import {todos as Todos} from '../Components/Todos.purs'
import Footer from '../Views/Footer'
import React, {Component} from 'react'

import 'todomvc-common/base.css'
import 'todomvc-app-css/index.css'

export default class App extends Component {
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
