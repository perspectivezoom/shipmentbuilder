`import React from 'react'`
`import ReactRouter from 'react-router'`
`import routes from './routes'`

render = (handler, state) -> 
  React.render(React.createElement(handler, params: state.params), document.getElementById('app'))

ReactRouter.run(routes, ReactRouter.HistoryLocation, render)