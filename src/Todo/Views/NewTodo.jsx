import React, {Component} from 'react'

export default class NewTodo extends Component {
  render () {
    const {addTodo, nextId} = this.props
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
}
