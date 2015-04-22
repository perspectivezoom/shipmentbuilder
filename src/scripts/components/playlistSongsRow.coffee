`import React from 'react'`
`import Actions from '../actions'`

{div, img, i} = React.DOM

PlaylistSongsRow = React.createClass
  handleRemoveClick: ->
    Actions.playlistRemoveSong @props.song

  render: ->
    {song, index} = @props
    div className: 'playlist-songs-row flex-horizontal',
      div className: 'flex-item-fixed',
        i onClick: @handleRemoveClick, className: 'fa fa-times playlist-songs-row__remove-icon'
      div className: 'flex-item-fixed playlist-songs-row__bullet', "(#{index + 1}) "
      div className: 'flex-item-fluid', song.title

`export default PlaylistSongsRow`