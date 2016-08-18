import React from 'react'

export default function Controls ({remaining, hidden, showClear}) {
  if (hidden) return null
  return (
    <footer className="footer">
      <span className="todo-count">{remaining}</span>
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
      {showClear && <button className="clear-completed">Clear completed</button>}
    </footer>
  )
}
