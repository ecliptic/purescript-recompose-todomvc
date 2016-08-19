import React from 'react'
import Todo from 'Todo/Views/Todo'

export default function Todos ({allCompleted, todos, toggleCompleteAll}) {
  return (
    <section className="main">
      <input className="toggle-all"
        type="checkbox"
        name="toggle"
        checked={!allCompleted}
        onClick={toggleCompleteAll} />
      <label htmlFor="toggle-all">Mark all as complete</label>
      <ul className="todo-list">
        {todos && todos.map(todo => <Todo todo={todo} key={todo.id} />)}
      </ul>
    </section>
  )
}
