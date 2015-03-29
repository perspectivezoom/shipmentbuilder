`import React from 'react'`
`import ReactRouter from 'react-router'`

{div} = React.DOM
[link] = (React.createFactory(component) for component in [ReactRouter.Link])

Header = React.createClass
  render: ->
    div className: "header",
      div className: "header__bar flex-horizontal",
        link to: "/", className: "flex-item-fixed header__logo", "Karaoke Playlist"
        div className: "flex-item-fluid"

`export default Header`