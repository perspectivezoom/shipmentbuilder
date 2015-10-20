`import _ from 'lodash'`
`import d3 from 'd3'`
`import React from 'react'`
`import Reflux from 'reflux'`
`import Actions from '../actions'`
`import NodeModal from './nodeModal'`
`import EdgeModal from './edgeModal'`
`import NodePanel from './nodePanel'`
`import EdgeLine from './edgeLine'`

{div, svg} = React.DOM
[nodeModal, edgeModal, nodePanel, edgeLine] = (React.createFactory(component) for component in [NodeModal, EdgeModal, NodePanel, EdgeLine])

{width, height, linkDistance, charge, midY, midX, startingY, endingY} = {}

ShipmentDiagram = React.createClass
  getInitialState: ->
    @calculateConfig()
    nodeInfoToEdit: null
    positions: @calculateStartingPositions(@props.shipment)
    links: @calculateStartingLinks(@props.shipment)

  calculateConfig: ->
    width = 600
    height = 600
    linkDistance = height / @props.shipment.nodes.length
    charge = -4 * width
    midY = height / 2
    midX = width / 2
    startingY = 100
    endingY = height - 100

  calculateStartingPositions: (shipment) ->
    positions = []
    _.each shipment.nodes, (node, index) ->
      position = x: midX + index
      if node.starting
        position.y = startingY
        position.starting = true
      else if node.ending
        position.y = endingY
        position.ending = true
      else
        position.y = midY
      positions.push position
    positions

  calculateStartingLinks: (shipment) ->
    nodeNames = _.map shipment.nodes, 'name'
    links = []
    for edge in shipment.edges
      links.push
        source: _.indexOf nodeNames, edge.from
        target: _.indexOf nodeNames, edge.to
    links

  componentDidMount: ->
    force = d3.layout.force()
      .linkDistance(linkDistance)
      .charge(charge)
      .size([width, height])
      .nodes(@state.positions)
      .links(@state.links)
      .start()

    force.on 'tick', =>
      @reLevelY()
      @forceUpdate()

    force.on 'end', =>
      @setState positions: @state.positions, links: @state.links

  reLevelY: ->
    for position in @state.positions
      position.y = startingY if position.starting
      position.y = endingY if position.ending

  resetEverything: ->
    @calculateConfig()
    @state.positions = @calculateStartingPositions(@props.shipment)
    @state.links = @calculateStartingLinks(@props.shipment)
    _.defer => @componentDidMount()

  onAddClick: (edgeToComplete) ->
    @setState nodeInfoToEdit: {node: {}, edge: edgeToComplete}

  onNodeEditClick: (node) ->
    @setState nodeInfoToEdit: {node, edge: null}

  onNodeModalSubmit: ->
    @setState nodeInfoToEdit: null

  onEdgeEditClick: (edge) ->
    @setState edgeToEdit: edge

  onEdgeModalSubmit: ->
    @setState edgeToEdit: null

  render: ->
    if @props.shipment.nodes && @props.shipment.nodes.length != @state.positions.length
      @resetEverything()
      return null

    div className: "shipment-diagram",
      if _.isEmpty @props.shipment.nodes
        nodeModal
          initialNodeParams: {}
      if @state.nodeInfoToEdit
        nodeModal
          initialNodeParams: @state.nodeInfoToEdit.node
          edgeToComplete: @state.nodeInfoToEdit.edge
          onSubmit: @onNodeModalSubmit
      if @state.edgeToEdit
        edgeModal
          initialEdgeParams: @state.edgeToEdit
          onSubmit: @onEdgeModalSubmit

      svg {width, height},
        _.map @props.shipment.edges, (edge, index) =>
          link = @state.links[index]
          return null unless _.isObject link
          edgeLine {edge, link, key: index, onEdgeSelect: @props.onEdgeSelect, onEdgeEditClick: @onEdgeEditClick, hideActions: @props.hideActions}

        _.map @props.shipment.nodes, (node, index) =>
          pos = @state.positions[index]
          nodePanel {node, pos, key: node.name, onAddClick: @onAddClick, onNodeSelect: @props.onNodeSelect, onNodeEditClick: @onNodeEditClick, hideActions: @props.hideActions}

`export default ShipmentDiagram`