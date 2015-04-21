`import React from 'react'`
`import config from '../config'`

{div, text, a, i, button} = React.DOM

PlaylistDirections = React.createClass
  render: ->
    playlistPath = "#{config.site.rootPath}/playlists/#{@props.playlistSlug}"

    div className: 'playlist-directions flex-horizontal',
      div className: 'playlist-directions__step flex-horizontal flex-item-fluid flex-center-align-items',
        div className: 'flex-item-fluid'
        div className: 'flex-item-fixed',
          text {}, '(1) Share this playlist: '
          a href: "/playlists/#{@props.playlistSlug}", playlistPath
        div className: 'flex-item-fluid'
      div className: 'playlist-directions__step flex-horizontal flex-item-fluid flex-center-align-items',
        div className: 'flex-item-fluid'
        div className: 'flex-item-fixed',
          text {}, '(2) Add Songs'
        div className: 'flex-item-fluid'
      div className: 'playlist-directions__step flex-horizontal flex-item-fluid flex-center-align-items',
        div className: 'flex-item-fluid'
        div className: 'flex-item-fixed',
          text {}, '(3) '
          a className: 'button', href: "/player/#{@props.playlistSlug}",
            i className: 'fa fa-music'
            text {}, 'Go to Player'
        div className: 'flex-item-fluid'

`export default PlaylistDirections`