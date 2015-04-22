`import Reflux from 'reflux'`
`import Actions from '../actions'`
`import FirebaseService from '../services/firebaseService'`

PlaylistStore = Reflux.createStore
  listenables: [Actions]

  init: ->
    @state = {songs: [], loaded: false, slug: @playlistSlug}

  onPlaylistAddSong: (song) ->
    FirebaseService.addSongToPlaylist @playlistSlug, song

  onPlaylistRemoveSong: (song) ->
    FirebaseService.removeSongFromPlaylist @playlistSlug, song

  onPlaylistSlugChange: (@playlistSlug) ->
    @trigger (@state = {songs: [], loaded: false, slug: @playlistSlug})
    FirebaseService.listenToPlaylist @playlistSlug, (songs) =>
      @trigger (@state = {songs, loaded: true, slug: @playlistSlug})

  getInitialState: -> @state

`export default PlaylistStore`