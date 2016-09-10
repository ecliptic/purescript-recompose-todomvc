import {newTodo as NewTodo} from 'Todo/Components/NewTodo.purs'
import {controls as Controls} from 'Todo/Components/Controls.purs'
import Footer from 'Todo/Views/Footer'
import React, {Component} from 'react'
import {todos as Todos} from 'Todo/Components/Todos.purs'

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
