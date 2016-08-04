import React from 'react'
import Todo from 'Todo/Components/Todos'

export default function Todos ({allCompleted, todos}) {
  return (
    <section className="main">
      <input className="toggle-all"
        type="checkbox"
        name="toggle"
        checked={allCompleted}
        onClick={(...args) => console.log('toggle onClick', args)} />
      <label htmlFor="toggle-all">Mark all as complete</label>
      <ul className="todo-list">
        {todos && todos.map(todo => <Todo todo={todo} key={todo.id} />)}
      </ul>
    </section>
  )
}
