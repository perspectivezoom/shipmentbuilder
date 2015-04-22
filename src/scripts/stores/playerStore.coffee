`import _ from 'lodash'`
`import Reflux from 'reflux'`
`import Actions from '../actions'`
`import PlaylistStore from './playlistStore'`

PlayerStore = Reflux.createStore
  listenables: [Actions]

  init: ->
    @state = {currentSong: null, loaded: false}
    @listenTo(PlaylistStore, @onPlaylistChange)

  getCurrentSong: ->
    return null if !@playlist or !@playlist.loaded or @playlist.songs.length == 0
    lastPlayedEntryId = localStorage.getItem("#{@playlist.slug}:lastPlayedEntryId")
    return @playlist.songs[0] unless lastPlayedEntryId
    index = _.chain(@playlist.songs).pluck('id').indexOf(lastPlayedEntryId).value()
    if !_.isNumber(index) or index == (@playlist.songs.length - 1)
      @playlist.songs[0]
    else
      @playlist.songs[index + 1]

  onPlaylistChange: (@playlist) ->
    @trigger (@state = {currentSong: @getCurrentSong(), loaded: @playlist.loaded})
    
  onPlayerAdvanceSong: ->
    localStorage.setItem "#{@playlist.slug}:lastPlayedEntryId", @state.currentSong.id
    @trigger (@state = {currentSong: @getCurrentSong(), loaded: @playlist.loaded})

  getInitialState: -> @state

`export default PlayerStore`