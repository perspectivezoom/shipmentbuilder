`import _ from 'lodash'`
`import React from 'react'`
`import Actions from '../actions'`

{div, img, button} = React.DOM

SongSelectorRow = React.createClass
  handleAddClick: _.debounce (->
      Actions.playlistAddSong @props.song
    ), 1000, leading: true, trailing: false
  
  render: ->
    div {},
      div {}, @props.song.title
      img src: @props.song.thumbnailUrl
      button onClick: @handleAddClick, "Add"

`export default SongSelectorRow`