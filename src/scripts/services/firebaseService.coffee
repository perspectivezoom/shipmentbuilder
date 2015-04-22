`import _ from 'lodash'`
`import Firebase from 'firebase'`
`import config from '../config'`

class FirebaseService
  constructor: ->
    @playlistsRef = new Firebase(config.firebase.rootUrl + '/playlists/')

  addSongToPlaylist: (playlistSlug, song) ->
    playlistEntryRef = @playlistsRef.child(playlistSlug).push()
    _.extend song, id: playlistEntryRef.key()
    playlistEntryRef.set song

  removeSongFromPlaylist: (playlistSlug, song) ->
    songRef = @playlistsRef.child(playlistSlug).child(song.id)
    songRef.remove()

  listenToPlaylist: (playlistSlug, callback) ->
    @playlistsRef.child(playlistSlug).on 'value', (snapshot) ->
      entries = _.sortBy (snapshot.val() or {}), 'id'
      callback(entries)

`export default new FirebaseService`