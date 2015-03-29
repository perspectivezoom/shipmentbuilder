`import Reflux from 'reflux'`
`import Actions from '../actions'`
`import YoutubeService from '../services/youtubeService'`

SongSelectorAutocompleteStore = Reflux.createStore
  listenables: [Actions]
  
  onSongSelectorAutocompleteSearch: (searchTerm) ->
    @trigger (@state = {searchTerm, songs: [], loaded: false})
    YoutubeService.search(searchTerm).then (songs) =>
      @trigger (@state = {searchTerm, songs, loaded: true})
  
  getInitialState: ->
    @state = {searchTerm: "", songs: [], loaded: true}

`export default SongSelectorAutocompleteStore`