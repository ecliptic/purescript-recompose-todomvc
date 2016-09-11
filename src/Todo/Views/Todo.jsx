import React, {Component} from 'react'
import classnames from 'classnames'

const blurTarget = event => event.target.blur()

export default class Todo extends Component {
  render () {
    const {todo, toggle, editTodo, updateTodo} = this.props
    return (
      <li className={classnames({completed: todo.completed, editing: todo.editing})}>
        <div className="view">
          <input className="toggle"
            type="checkbox"
            checked={todo.completed}
            onClick={toggle} />
          <label onDoubleClick={editTodo}>
            {todo.title}
          </label>
        </div>
        <input className="edit"
          defaultValue={todo.title}
          name="title"
          id={`todo-${todo.id}`}
          onBlur={updateTodo}
          onKeyPress={blurTarget} />
      </li>
    )
  }
}
