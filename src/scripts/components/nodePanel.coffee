`import _ from 'lodash'`
`import React from 'react'`
`import Actions from '../actions'`

{div, button, i, text, circle, g} = React.DOM

radius = 40
btnRadius = radius / 4

NodePanel = React.createClass
  onDestroyClick: ->
    Actions.nodeDestroy @props.node

  render: ->
    node = @props.node
    pos = @props.pos
    originPos = {x: pos.x - radius, y: pos.y - radius}
    destPos = {x: pos.x - radius, y: pos.y + radius}
    infoPos = {x: pos.x + radius + 2 * btnRadius, y: pos.y}
    dataPos = {x: infoPos.x + 2 * btnRadius, y: pos.y}
    keyIndex = -1
    nodeAdditionalAttributes = _.omit(node, 'name', 'starting', 'ending', 'selected')
    g {},
      circle cx: pos.x, cy: pos.y, r: radius, stroke: "steelblue", strokeWidth: 3, fill: "white"
      text x: pos.x, y: pos.y, fontSize: 20, fill: 'black', textAnchor: 'middle', style: {dominantBaseline: 'central'}, node.name
      unless @props.hideActions
        g {},
          if node.starting or node.ending
            text x: pos.x, y: pos.y + 25, fontSize: 10, fill: 'red', textAnchor: 'middle', fontFamily: "FontAwesome", onClick: @onDestroyClick, style: {dominantBaseline: 'central', cursor: 'pointer'}, '\uf00d'
          text x: pos.x, y: pos.y - 25, fontSize: 10, fill: 'steelblue', textAnchor: 'middle', fontFamily: "FontAwesome", onClick: (=> @props.onNodeEditClick(node)), style: {dominantBaseline: 'central', cursor: 'pointer'}, '\uf040'
      unless @props.hideActions
        g {},
          g style: {cursor: 'pointer'}, onClick: _.partial(@props.onAddClick, to: @props.node.name),
            circle cx: originPos.x, cy: originPos.y, r: btnRadius, stroke: "steelblue", strokeWidth: 2, fill: "white"
            text x: originPos.x, y: originPos.y, fontSize: 20, fill: 'black', textAnchor: 'middle', fontFamily: "FontAwesome", style: {dominantBaseline: 'central'}, '\uf148'
          g style: {cursor: 'pointer'}, onClick: _.partial(@props.onAddClick, from: @props.node.name),
            circle cx: destPos.x, cy: destPos.y, r: btnRadius, stroke: "steelblue", strokeWidth: 2, fill: "white"   
            text x: destPos.x, y: destPos.y, fontSize: 20, fill: 'black', textAnchor: 'middle', fontFamily: "FontAwesome", style: {dominantBaseline: 'central'}, '\uf149'
          g style: {cursor: 'pointer'}, onClick: (=> @props.onNodeSelect(node, !node.selected)),
            circle cx: infoPos.x, cy: infoPos.y, r: btnRadius, stroke: "steelblue", strokeWidth: 2, fill: (if node.selected then "steelblue" else "white")
            text x: infoPos.x, y: infoPos.y, fontSize: 20, fill: 'black', textAnchor: 'middle', fontFamily: "FontAwesome", style: {dominantBaseline: 'central'}, '\uf129'
      if node.selected
        g {},
          if _.isEmpty nodeAdditionalAttributes
            text x: dataPos.x, y: dataPos.y,  fontSize: 12, fill: 'black', style: {dominantBaseline: 'central'}, "No Additional Info"
          else
            _.map nodeAdditionalAttributes, (value, key) =>
              keyIndex += 1
              text key: keyIndex, x: dataPos.x, y: dataPos.y + keyIndex * 15,  fontSize: 12, fill: 'black', style: {dominantBaseline: 'central'}, "#{key}: #{value}"

`export default NodePanel`