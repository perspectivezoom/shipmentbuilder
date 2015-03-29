`import React from 'react'`
`import ReactRouter from 'react-router'`
`import Header from './header'`

{div} = React.DOM
[routeHandler, header] = (React.createFactory(component) for component in [ReactRouter.RouteHandler, Header])

App = React.createClass
  render: ->
    div {},
      header()
      routeHandler @props

`export default App`