import React from 'react'

export default function NewTodo ({addTodo, nextId}) {
  return (
    <header className="header">
      <h1>todos</h1>
      <input className="new-todo"
        key={nextId}
        placeholder="What needs to be done?"
        autoFocus
        name="newTodo"
        onKeyPress={addTodo} />
    </header>
  )
}
