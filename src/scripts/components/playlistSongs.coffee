`import _ from 'lodash'`
`import React from 'react'`
`import Reflux from 'reflux'`
`import PlaylistStore from '../stores/playlistStore'`

{div} = React.DOM

PlaylistSongs = React.createClass
  mixins: [Reflux.connect(PlaylistStore, "playlist")]
  render: ->
    div {},
      div {}, _.map @state.playlist.songs, (song) ->
        div key: song.id, 
          div {}, song.title

`export default PlaylistSongs`