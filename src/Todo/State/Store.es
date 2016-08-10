import {PropTypes} from 'react'

const channelPropType = PropTypes.shape({
  get: PropTypes.func.isRequired,
  set: PropTypes.func.isRequired,
  subscribe: PropTypes.func.isRequired
}).isRequired

export const storePropType = PropTypes.shape({
  actionChannel: channelPropType,
  effectChannel: channelPropType,
  stateSignal: channelPropType
}).isRequired
