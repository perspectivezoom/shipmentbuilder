`import React from 'react'`

{div, img} = React.DOM

PlaylistSongsRow = React.createClass
  render: ->
    {song, index} = @props
    div className: 'playlist-songs-row flex-horizontal',
      div className: 'flex-item-fixed playlist-songs-row__bullet', "(#{index + 1}) "
      div className: 'flex-item-fluid', song.title

`export default PlaylistSongsRow`