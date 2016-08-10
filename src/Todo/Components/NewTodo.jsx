import React from 'react'

export default function NewTodo ({addTodo}) {
  console.log('addTodo ->', addTodo)
  return (
    <header className="header">
      <h1>todos</h1>
      <input className="new-todo"
        placeholder="What needs to be done?"
        autoFocus
        name="newTodo"
        onKeyPress={event => (event.key === 'Enter') && addTodo(event.target.value)}>
      </input>
    </header>
  )
}

export const component = NewTodo
