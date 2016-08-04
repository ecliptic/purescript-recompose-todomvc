import React from 'react'

export default function Controls ({count}) {
  return (
    <footer className="footer">
      <span className="todo-count">{count}</span>
      <ul className="filters">
        <li>
          <a href="#/"
            className="selected"
            onClick={(...args) => console.log('filter all', args)}>
            All
          </a>
        </li>
        <li>
          <a href="#/active"
            onClick={(...args) => console.log('filter active', args)}>
            Active
          </a>
        </li>
        <li>
          <a href="#/completed"
            onClick={(...args) => console.log('filter completed', args)}>
            Completed
          </a>
        </li>
      </ul>
      <button className="clear-completed">Clear completed</button>
    </footer>
  )
}
