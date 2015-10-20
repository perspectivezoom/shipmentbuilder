`import _ from 'lodash'`
`import Firebase from 'firebase'`
`import config from '../config'`

class FirebaseService
  constructor: ->
    @shipmentsRef = new Firebase(config.firebase.rootUrl + '/shipments/')

  saveShipment: (shipmentSlug, shipment) ->
    songRef = @shipmentsRef.child(shipmentSlug).set(shipment)

  listenToShipment: (shipmentSlug, callback) ->
    @shipmentsRef.child(shipmentSlug).on 'value', (snapshot) ->
      callback(snapshot.val() or {})

`export default new FirebaseService`