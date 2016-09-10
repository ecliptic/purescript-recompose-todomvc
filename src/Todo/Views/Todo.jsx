import React from 'react'
import classnames from 'classnames'

export default function Todo ({todo, toggle}) {
  console.log('toggle ->', toggle)
  return (
    <li className={classnames({completed: todo.completed, editing: todo.editing})}>
      <div>
        <input className="toggle"
          type="checkbox"
          checked={todo.completed}
          onClick={toggle} />
        <label>
          {todo.text}
        </label>
      </div>
    </li>
  )
}
