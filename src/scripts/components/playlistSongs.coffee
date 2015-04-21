`import _ from 'lodash'`
`import React from 'react'`
`import Reflux from 'reflux'`
`import PlaylistStore from '../stores/playlistStore'`
`import PlaylistSongsRow from './playlistSongsRow'`

{div} = React.DOM
[playlistSongsRow] = (React.createFactory(component) for component in [PlaylistSongsRow])

PlaylistSongs = React.createClass
  mixins: [Reflux.connect(PlaylistStore, "playlist")]
  render: ->
    div className: 'playlist-songs',
      div className: 'playlist-songs__title', "Playlist #{@props.playlistSlug}"
      if !@state.playlist.loaded
        div className: 'playlist-songs__blank-slate', 'Loading...'
      else if @state.playlist.songs.length
        div {}, _.map(@state.playlist.songs, (song, index) ->
          playlistSongsRow {song, index, key: song.id}
        ).reverse()
      else
        div className: 'playlist-songs__blank-slate', 'No Songs in Playlist Yet'
          
`export default PlaylistSongs`