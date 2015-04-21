`import React from 'react'`
`import ReactRouter from 'react-router'`

[routeHandler] = (React.createFactory(component) for component in [ReactRouter.RouteHandler])

App = React.createClass
  render: ->
    routeHandler @props

`export default App`