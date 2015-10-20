`import _ from 'lodash'`
`import Reflux from 'reflux'`
`import Actions from '../actions'`
`import FirebaseService from '../services/firebaseService'`

ShipmentStore = Reflux.createStore
  listenables: [Actions]

  init: ->
    @state = {nodes: [], edges: [], loaded: false}

  onNodeSave: (oldNodeName, node, edgeToComplete) ->
    node = _.omit node, 'starting', 'ending', 'selected'
    existingNodeIndex = _.indexOf _.map(@state.nodes, 'name'), oldNodeName
    nodes = _.clone @state.nodes
    edges = _.clone @state.edges

    if existingNodeIndex > -1
      existingNode = nodes[existingNodeIndex]
      nodes[existingNodeIndex] = node
      if node.name != existingNode.name
        (edge.to = node.name) for edge in edges when edge.to == existingNode.name
        (edge.from = node.name) for edge in edges when edge.from == existingNode.name
    else
      nodes = nodes.concat node

    if edgeToComplete?.from
      edgeToComplete.to = node.name
      edges = edges.concat edgeToComplete
    else if edgeToComplete?.to
      edgeToComplete.from = node.name
      edges = edges.concat edgeToComplete

    shipment = _.extend {}, @dbShipment(), {nodes, edges}
    FirebaseService.saveShipment @shipmentSlug, shipment

  dbShipment: ->
    _.pick @state, 'nodes', 'edges'

  onNodeDestroy: (node) ->
    nodes = _.clone @state.nodes
    edges = _.clone @state.edges
    nodes = _.reject nodes, (candidate) -> candidate.name == node.name
    edges = _.reject edges, (edge) -> edge.to == node.name or edge.from == node.name
    shipment = _.extend {}, @dbShipment(), {nodes, edges}
    FirebaseService.saveShipment @shipmentSlug, shipment

  onEdgeUpdate: (edge) ->
    existingEdgeIndex = _.findIndex @state.edges, (candidate) -> candidate.to == edge.to and candidate.from = edge.from 
    edges = _.clone @state.edges
    edge = _.omit edge, 'from', 'to', 'selected'
    edges[existingEdgeIndex] = _.extend {}, edges[existingEdgeIndex], edge
    shipment = _.extend {}, @dbShipment(), {edges}
    FirebaseService.saveShipment @shipmentSlug, shipment

  onShipmentSlugChange: (@shipmentSlug) ->
    @trigger (@state = {nodes: [], edges: [], loaded: false, slug: @shipmentSlug})
    FirebaseService.listenToShipment @shipmentSlug, (shipment) =>
      shipment = _.extend {nodes: [], edges: [], slug: @shipmentSlug, loaded: true}, shipment
      @annotateStartingAndEndingNodes(shipment)
      @trigger (@state = shipment)

  annotateStartingAndEndingNodes: (shipment) ->
    edgeFroms = (edge.from for edge in shipment.edges)
    edgeTos = (edge.to for edge in shipment.edges)
    _.each shipment.nodes, (node) ->
      node.starting = !_.contains edgeTos, node.name
      node.ending = !_.contains edgeFroms, node.name
      node

  getInitialState: -> @state

`export default ShipmentStore`