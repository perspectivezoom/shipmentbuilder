`import _ from 'lodash'`
`import React from 'react'`
`import Modal from 'react-modal'`
`import Actions from '../actions'`

Modal.setAppElement document.body

{div, span, label, input, button, i, text} = React.DOM
[modal] = (React.createFactory(component) for component in [Modal])

nodeModal = React.createClass
  propTypes:
    onSaveSuccess: React.PropTypes.func
    initialNodeParams: React.PropTypes.object.isRequired

  emptyNode: ->
    {name: '', lastFreeDayDate: "Jan 1 1999", cargoReadyDate: "Jan 3, 1999"}

  getInitialState: ->
    node: _.extend @emptyNode(), @props.initialNodeParams

  onAttributeChange: (keyName, event) ->
    value = event.currentTarget.value
    change = {}
    change[keyName] = value
    node = _.extend {}, @state.node, change
    @setState {node}

  onSaveClick: ->
    Actions.nodeSave @props.initialNodeParams.name, @state.node, @props.edgeToComplete
    @props.onSubmit?()

  render: ->
    modal isOpen: true,
      div className: 'node-modal modal-dialog',
        div {}, "Location #{@state.node.name}"
        div className: "form-horizontal",
          _.map @state.node, (value, key) =>
            return null if key == 'starting' or key == 'ending' or key == 'selected'
            div {key, className: "form-group"},
              label className: "control-label col-sm-2", key
              div className: "col-sm-10",
                input
                  className: "form-control"
                  value: value
                  onChange: _.partial(@onAttributeChange, key)
        div className: "row",
          div className: "col-md-2",
            button type: 'button', className: 'button home__go-to-playlist-button', onClick: @onSaveClick,
              i className: 'fa fa-save'
              text {}, 'Save'
          div className: "col-md-2",
            button type: "button", className: "button home__go-to-playlist-button", onClick: @props.onSubmit,
              text {}, "Cancel"
          div className: "col-md-8"

`export default nodeModal`