import React, {Component} from 'react'

export default class Controls extends Component {
  render () {
    const {remaining, hidden, showClear, filterAll, filterActive, filterCompleted, clearCompleted} = this.props
    if (hidden) return null
    return (
      <footer id="footer">
        <span className="todo-count">{remaining}</span>
        <ul className="filters">
          <li>
            <a href="#/"
              className="selected"
              onClick={filterAll}>
              All
            </a>
          </li>
          <li>
            <a href="#/active"
              onClick={filterActive}>
              Active
            </a>
          </li>
          <li>
            <a href="#/completed"
              onClick={filterCompleted}>
              Completed
            </a>
          </li>
        </ul>
        {showClear && <button className="clear-completed"
          onClick={clearCompleted}>
          Clear completed
        </button>}
      </footer>
    )
  }
}
