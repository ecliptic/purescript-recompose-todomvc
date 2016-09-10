import {config} from 'config'
import {prefixLink} from 'gatsby-helpers'
import DocumentTitle from 'react-document-title'
import React, {Component} from 'react'

const BUILD_TIME = new Date().getTime()

export default class Html extends Component {

  static displayName = 'HTML'

  render () {
    const {body} = this.props
    const title = DocumentTitle.rewind()

    let css
    if (process.env.NODE_ENV === 'production') {
      css = <style dangerouslySetInnerHTML={{ __html: require('!raw!../../public/styles.css') }} />
    }

    return (
      <html lang="en">
        <head>
          <title>{title}</title>
          <meta charSet="utf-8" />
          <meta httpEquiv="X-UA-Compatible" content="IE=edge" />
          <meta name="viewport"
            content="width=device-width, initial-scale=1.0" />
          <meta name="author" content="Brandon Konkle" />
          <meta name="description" content={config.description} />
          <meta name="generator" content="Gatsby" />
          <link rel="canonical" href="http://ecliptic.github.io/purescript-recompose-todomvc" />
          {css}
        </head>
        <body>
          <main id="react-mount" dangerouslySetInnerHTML={{ __html: body }} />
          <script src={prefixLink(`/bundle.js?t=${BUILD_TIME}`)} />
        </body>
      </html>
    )
  }

}
