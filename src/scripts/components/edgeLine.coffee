`import _ from 'lodash'`
`import React from 'react'`
`import Actions from '../actions'`

{line, g, circle, text} = React.DOM

btnRadius = 10
transportationModeToIcon = 
  ship: "\uf21a"
  train: "\uf238"
  truck: "\uf0d1"

EdgeLine = React.createClass
  render: ->
    {edge, link} = @props
    {source, target} = link
    return null unless _.isObject(source) and _.isObject(target)
    midX = (source.x + target.x) / 2
    midY = (source.y + target.y) / 2
    infoPos = {x: midX + btnRadius * 2, y: midY}
    editPos = {x: midX - btnRadius * 2, y: midY}
    dataPos = {x: infoPos.x + btnRadius * 2, y: infoPos.y}
    keyIndex = -1
    edgeAdditionalAttributes = _.omit edge, 'from', 'to', 'selected', 'transportationMode'
    infoIcon = transportationModeToIcon[edge.transportationMode] or '\uf129'
    g {},
      line x1: source.x, y1: source.y, x2: target.x, y2: target.y, strokeWidth: 3, stroke: "black"
      g style: {cursor: 'pointer'}, onClick: (=> @props.onEdgeSelect(edge, !edge.selected)),
        circle cx: infoPos.x, cy: infoPos.y, r: btnRadius, fill: (if edge.selected then "steelblue" else "white")
        text x: infoPos.x, y: infoPos.y, fontSize: 20, fill: 'black', textAnchor: 'middle', fontFamily: "FontAwesome", style: {dominantBaseline: 'central'}, infoIcon
      unless @props.hideActions
        g style: {cursor: 'pointer'}, onClick: (=> @props.onEdgeEditClick(edge)),
          text x: editPos.x, y: editPos.y, fontSize: 10, fill: 'steelblue', textAnchor: 'middle', fontFamily: "FontAwesome", style: {dominantBaseline: 'central', cursor: 'pointer'}, '\uf040'
      if edge.selected
        g {},
          if _.isEmpty edgeAdditionalAttributes
            text x: dataPos.x, y: dataPos.y,  fontSize: 12, fill: 'black', style: {dominantBaseline: 'central'}, "No Additional Info"
          else
            _.map edgeAdditionalAttributes, (value, key) =>
              keyIndex += 1
              text key: keyIndex, x: dataPos.x, y: dataPos.y + keyIndex * 15,  fontSize: 12, fill: 'black', style: {dominantBaseline: 'central'}, "#{key}: #{value}"

`export default EdgeLine`