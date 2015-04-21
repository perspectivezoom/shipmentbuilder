`import _ from 'lodash'`
`import React from 'react'`
`import Actions from '../actions'`

{div, img, text, i, button} = React.DOM

SongSelectorRow = React.createClass
  handleAddClick: _.debounce (->
      Actions.playlistAddSong @props.song
    ), 1000, leading: true, trailing: false
  
  render: ->
    div className: "song-selector-row flex-horizontal flex-center-align-items",
      img src: @props.song.thumbnailUrl, className: "flex-item-fixed"
      button onClick: @handleAddClick, className: "flex-item-fixed button song-selector-row__add-button",
        i className: "fa fa-plus-square-o"
        text {}, "Add"
      div className: "flex-item-fluid", @props.song.title

`export default SongSelectorRow`