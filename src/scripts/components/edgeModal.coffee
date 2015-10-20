`import _ from 'lodash'`
`import React from 'react'`
`import Modal from 'react-modal'`
`import Actions from '../actions'`

Modal.setAppElement document.body

{div, span, label, input, select, option, button, i, text} = React.DOM
[modal] = (React.createFactory(component) for component in [Modal])

edgeModal = React.createClass
  emptyEdge: ->
    {transportationMode: 'train', departureDate: "Jan 1 1999", arrivalDate: "Jan 3, 1999"}

  getInitialState: ->
    edge: _.extend @emptyEdge(), @props.initialEdgeParams

  onAttributeChange: (keyName, event) ->
    value = event.currentTarget.value
    change = {}
    change[keyName] = value
    edge = _.extend {}, @state.edge, change
    @setState {edge}

  onSaveClick: ->
    Actions.edgeUpdate @state.edge
    @props.onSubmit?()

  render: ->
    edge = @state.edge
    modal isOpen: true,
      div className: 'edge-modal modal-dialog',
        div {}, "Connection between #{edge.from} and #{edge.to}"
        div className: "form-horizontal",
          _.map edge, (value, key) =>
            return null if key == 'from' or key == 'to' or key == 'selected'
            div {key, className: "form-group"},
              label className: "control-label col-sm-2", key
              div className: "col-sm-10",
                if key != 'transportationMode'
                  input
                    className: "form-control"
                    value: value
                    onChange: _.partial(@onAttributeChange, key)
                else
                  select {
                      className: "form-control"
                      value: value
                      fontFamily: "FontAwesome"
                      onChange: _.partial(@onAttributeChange, key)
                    },
                    option value: "ship", "Ship"
                    option value: "train", "Train"
                    option value: "truck", "Truck"
        div className: "row",
          div className: "col-md-2",
            button type: 'button', className: 'button home__go-to-playlist-button', onClick: @onSaveClick,
              i className: 'fa fa-save'
              text {}, 'Save'
          div className: "col-md-2",
            button type: "button", className: "button home__go-to-playlist-button", onClick: @props.onSubmit,
              text {}, "Cancel"
          div className: "col-md-8"

`export default edgeModal`