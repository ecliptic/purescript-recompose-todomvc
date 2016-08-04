import React from 'react'

export default function NewTodo ({task}) {
  return (
    <header className="header">
      <h1>todos</h1>
      <input className="new-todo"
        placeholder="What needs to be done?"
        autoFocus
        value={task}
        name="newTodo"
        onInput={(...args) => console.log('newTodo onInput', args)}>
        {/*onEnter={(...args) => console.log('newTodo onEnter', args)}>*/}
      </input>
    </header>
  )
}
