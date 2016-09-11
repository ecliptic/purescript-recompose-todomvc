# TodoMVC <<< React <<< Redux <<< Recompose $ PureScript

[![build status](https://img.shields.io/travis/bkonkle/purescript-recompose-todomvc/master.svg?style=flat-square)](https://travis-ci.org/bkonkle/purescript-recompose-todomvc)
[![recompose channel on discord](https://img.shields.io/badge/discord-%23redux%20%40%20reactiflux-61dafb.svg?style=flat-square)](https://discord.gg/2PCKqHc)

This is an implementation of [TodoMVC](http://todomvc.com/) using the following tools:

 - [PureScript](http://www.purescript.org/)
 - [React](https://facebook.github.io/react/)
 - [Redux](http://redux.js.org/)
 - [Recompose](https://github.com/acdlite/recompose)
 - [Gatsby](https://github.com/gatsbyjs/gatsby)
 - [Babel](http://babeljs.io/)
 - [Webpack](https://webpack.github.io/)

## [Try it live!](https://bkonkle.github.io/purescript-recompose-todomvc/)

The production build is
[currently deployed](https://bkonkle.github.io/purescript-recompose-todomvc/)
via Github Pages. ❤️

## Why the heck did you …?

### Use PureScript?

Front end development can be a stressful activity fraught with inscrutable bugs, race conditions, and endless production errors. PureScript gives you a sound, expressive type system heavily influenced by Haskell and similar to Elm. This gives developers the ability to eliminate runtime errors, take strict control of side effects, and take advantage of powerful functional abstractions.

### Use Recompose?

Recompose is an extremely powerful functional toolkit for working with React components that makes heavy use of higher-order components. This makes it easier to work with React in a functional, composable way.

### Use Gatsby?

Gatsby is ostensibly a static site generator based on React and Webpack, but it also provides easy extension points that can you can use to turn it into a universal application platform for many use cases. I extend it in `gatsby-node.js` to add PureScript support.

### Not use `purescript-redux`?

I wanted to use Redux in a way that is more idiomatic to ML-style languages like PureScript. For example, I wanted to use algebraic data types to represent action types. I decided to take some influence from `purescript-redux-utils` and use the ADT constructor names to automatically derive the string for Redux’s “type” attribute on actions.

The Redux helper used in this project will be open sourced as a separate module shortly.

### Separate PureScript “Components” from JSX “Views”?

I prefer to structure my applications with a strict functional core and an imperative shell (as influenced by the Destroy all Software talk [Boundaries](https://www.destroyallsoftware.com/talks/boundaries)). PureScript acts as the functional core with its sound type checking and well controlled side effects. JSX acts as the imperative shell wrapped around the core to provide the view layer for the Web. This makes it very easy to write views for other platforms like React Native that can share the core business logic and API integration.

## Build it!

First, clone the repo:

    $ git clone https://github.com/bkonkle/purescript-recompose-todomvc.git

Install dependencies:

		$ npm install

Run locally:

		$ npm start

## License

MIT
