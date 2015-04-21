`import React from 'react'`

{div} = React.DOM

SongSelectorBlankSlate = React.createClass
  render: ->
    div className: 'song-selector-blank-slate flex-vertical',
      div className: 'flex-item-fluid'
      div className: 'flex-item-fixed',
        div {}, @props.message
      div className: 'flex-item-fluid'

`export default SongSelectorBlankSlate`