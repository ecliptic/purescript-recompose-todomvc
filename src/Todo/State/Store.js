const React = require('react')
const PropTypes = React.PropTypes

const channelPropType = PropTypes.shape({
  get: PropTypes.func.isRequired,
  set: PropTypes.func.isRequired,
  subscribe: PropTypes.func.isRequired
}).isRequired

exports.storePropType = PropTypes.shape({
  actionChannel: channelPropType,
  effectChannel: channelPropType,
  stateSignal: channelPropType
}).isRequired
