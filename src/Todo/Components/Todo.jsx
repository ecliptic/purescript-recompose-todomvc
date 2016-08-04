import React from 'react'
import classnames from 'classnames'

export default function Todo ({todo}) {
  return (
    <li className={classnames({completed: todo.completed, editing: todo.editing})}>
      <div>
        <input className="toggle"
          type="checkbox"
          checked={todo.completed}
          onClick={(...args) => console.log('entry onClick', args)} />
        <label>
          {todo.description}
        </label>
      </div>
    </li>
  )
}
