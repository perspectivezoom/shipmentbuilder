`import React from 'react'`

{div, input} = React.DOM

PlayerBlankSlate = React.createClass
  render: ->
    div className: 'player-blank-slate flex-horizontal',
      div className: 'flex-item-fluid'
      div className: 'flex-item-fixed flex-vertical',
        div className: 'flex-item-fluid'
        div className: 'flex-item-fixed',
          div {}, @props.message
        div className: 'flex-item-fluid'
      div className: 'flex-item-fluid'

`export default PlayerBlankSlate`