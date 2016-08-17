import {newTodo as NewTodo} from 'Todo/Components/NewTodo.purs'
import Controls from 'Todo/Templates/Controls'
import Footer from 'Todo/Templates/Footer'
import React from 'react'
import {todos as Todos} from 'Todo/Components/Todos.purs'

import 'todomvc-common/base.css'
import 'todomvc-app-css/index.css'

export default function App () {
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
