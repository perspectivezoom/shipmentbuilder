`import Reflux from 'reflux'`
`import Actions from '../actions'`
`import FirebaseService from '../services/firebaseService'`

PlaylistStore = Reflux.createStore
  listenables: [Actions]

  onPlaylistAddSong: (song) ->
    FirebaseService.addSongToPlaylist @playlistSlug, song

  onPlaylistSlugChange: (@playlistSlug) ->
    @trigger (@state = {songs: [], loaded: false, slug: @playlistSlug})
    FirebaseService.listenToPlaylist @playlistSlug, (songs) =>
      @trigger (@state = {songs, loaded: true, slug: @playlistSlug})

  getInitialState: ->
    @state = {songs: [], loaded: false, slug: @playlistSlug}

`export default PlaylistStore`