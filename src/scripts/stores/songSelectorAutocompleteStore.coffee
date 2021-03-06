`import Reflux from 'reflux'`
`import Actions from '../actions'`
`import YoutubeService from '../services/youtubeService'`

SongSelectorAutocompleteStore = Reflux.createStore
  listenables: [Actions]

  init: ->
    @state = {searchTerm: "", songs: [], loaded: true}
  
  onSongSelectorAutocompleteSearch: (searchTerm) ->
    if searchTerm
      @trigger (@state = {searchTerm, songs: [], loaded: false})
      YoutubeService.search(searchTerm).then (songs) =>
        @trigger (@state = {searchTerm, songs, loaded: true})
    else
      @trigger (@state = {searchTerm, songs: [], loaded: true})

  getInitialState: -> @state

`export default SongSelectorAutocompleteStore`