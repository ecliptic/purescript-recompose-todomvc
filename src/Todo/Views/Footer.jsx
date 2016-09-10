import React, {Component} from 'react'

export default class Footer extends Component {
  render () {
    return (
      <footer className="info">
        <p>Double-click to edit a todo</p>
        <p>Written by <a href="http://konkle.us">Brandon Konkle</a></p>
        <p>Part of <a href="http://todomvc.com">TodoMVC</a></p>
      </footer>
    )
  }
}
