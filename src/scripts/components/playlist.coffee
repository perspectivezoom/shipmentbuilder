`import React from 'react'`
`import Reflux from 'reflux'`
`import Actions from '../actions'`
`import PlaylistHeader from './playlistHeader'`
`import PlaylistDirections from './playlistDirections'`
`import SongSelector from './songSelector'`
`import PlaylistSongs from './playlistSongs'`

{div} = React.DOM
[playlistHeader, playlistDirections, songSelector, playlistSongs] = (React.createFactory(component) for component in [PlaylistHeader, PlaylistDirections, SongSelector, PlaylistSongs])

Playlist = React.createClass
  componentDidMount: ->
    Actions.playlistSlugChange @props.params.playlistSlug
    
  render: ->
    div className: "flex-horizontal",
      div className: "flex-item-fluid"
      div className: "container flex-item-fixed",
        playlistHeader playlistSlug: @props.params.playlistSlug
        playlistDirections playlistSlug: @props.params.playlistSlug
        div className: "flex-horizontal",
          div className: "flex-item-fixed secondary-content",
            playlistSongs playlistSlug: @props.params.playlistSlug
          div className: "flex-item-fixed primary-content",
            songSelector {}
      div className: "flex-item-fluid"

`export default Playlist`