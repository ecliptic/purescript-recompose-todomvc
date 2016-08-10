import Controls from 'Todo/Components/Controls'
import Footer from 'Todo/Components/Footer'
import {newTodo as NewTodo} from 'Todo/Components/NewTodo.purs'
import React from 'react'
import Todos from 'Todo/Components/Todos'

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

export const component = App
