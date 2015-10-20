`import _ from 'lodash'`
`import React from 'react'`
`import Reflux from 'reflux'`
`import Actions from '../actions'`
`import ShipmentHeader from './shipmentHeader'`
`import ShipmentDiagram from './shipmentDiagram'`
`import ShipmentStore from '../stores/shipmentStore'`
`import NodeModal from './nodeModal'`

{div, button} = React.DOM
[shipmentHeader, shipmentDiagram] = (React.createFactory(component) for component in [ShipmentHeader, ShipmentDiagram])

Shipment = React.createClass
  mixins: [Reflux.connect(ShipmentStore, "shipment")]

  componentDidMount: ->
    Actions.shipmentSlugChange @props.params.shipmentSlug

  selectDeselectAll: ->
    if _.every @state.shipment.nodes, 'selected'
      desiredState = false
    else
      desiredState = true
    node.selected = desiredState for node in @state.shipment.nodes
    edge.selected = desiredState for edge in @state.shipment.edges
    @setState shipment: @state.shipment

  showHideActions: ->
    @setState hideActions: !@state.hideActions

  onNodeSelect: (node, desiredState) ->
    nodeIndex = _.indexOf _.map(@state.shipment.nodes, 'name'), node.name
    @state.shipment.nodes[nodeIndex].selected = desiredState
    @setState shipment: @state.shipment

  onEdgeSelect: (edge, desiredState) ->
    edgeIndex = _.findIndex @state.shipment.edges, (candidate) ->
      candidate.to == edge.to && candidate.from == edge.from
    @state.shipment.edges[edgeIndex].selected = desiredState
    @setState shipment: @state.shipment

  render: ->
    div className: "flex-horizontal",
      div className: "flex-item-fluid"
      div className: "container flex-item-fixed",
        shipmentHeader shipmentSlug: @props.params.shipmentSlug
        if !@state.shipment || !@state.shipment.loaded
          div {}, "Loading"
        else
          div {},
            button className: "pull-right", onClick: @selectDeselectAll, "Select / Deselect All"
            button className: "pull-right", onClick: @showHideActions, "Show / Hide Actions"
            div className: "clearfix"
            shipmentDiagram shipment: @state.shipment, hideActions: @state.hideActions, onNodeSelect: @onNodeSelect, onEdgeSelect: @onEdgeSelect

      div className: "flex-item-fluid"

`export default Shipment`