`import React from 'react'`
`import ReactRouter from 'react-router'`

`import App      from './components/app'`
`import Home     from './components/home'`
`import Shipment from './components/Shipment'`

route         = React.createFactory ReactRouter.Route
defaultRoute  = React.createFactory ReactRouter.DefaultRoute
notFoundRoute = React.createFactory ReactRouter.NotFoundRoute

routes =
  route handler: App, path: "/",
    route name: "shipments", handler: Shipment, path: "shipments/:shipmentSlug"
    defaultRoute name: "home", handler: Home

`export default routes`