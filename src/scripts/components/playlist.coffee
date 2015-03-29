`import React from 'react'`
`import Reflux from 'reflux'`
`import Actions from '../actions'`
`import SongSelector from './songSelector'`
`import PlaylistSongs from './playlistSongs'`

{div} = React.DOM
[songSelector, playlistSongs] = (React.createFactory(component) for component in [SongSelector, PlaylistSongs])

Playlist = React.createClass
  componentDidMount: ->
    Actions.playlistSlugChange @props.params.playlistSlug
    
  render: ->
    div {},
      div {}, "Playlist #{@props.params.playlistSlug}"
      songSelector {}
      playlistSongs {}

`export default Playlist`