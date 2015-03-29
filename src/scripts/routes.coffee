`import React from 'react'`
`import ReactRouter from 'react-router'`

`import App      from './components/app'`
`import Home     from './components/home'`
`import Playlist from './components/playlist'`
`import Player   from './components/player'`

route         = React.createFactory ReactRouter.Route
defaultRoute  = React.createFactory ReactRouter.DefaultRoute
notFoundRoute = React.createFactory ReactRouter.NotFoundRoute

routes =
  route handler: App, path: "/",
    route name: "playlists", handler: Playlist, path: "playlists/:playlistSlug"
    route name: "player", handler: Player, path: "player/:playlistSlug"
    defaultRoute name: "home", handler: Home

`export default routes`