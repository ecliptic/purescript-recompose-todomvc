import {config} from 'config'
import DocumentTitle from 'react-document-title'
import React from 'react'

export default function MarkdownWrapper ({route}) {
  const post = route.page.data
  return (
    <DocumentTitle title={`${post.title} | ${config.title}`}>
      <article>
        <h1 style={{marginTop: 0}}>{post.title}</h1>
        <div dangerouslySetInnerHTML={{__html: post.body}} />
      </article>
    </DocumentTitle>
  )
}

MarkdownWrapper.propTypes = {
  route: React.PropTypes.object,
}
