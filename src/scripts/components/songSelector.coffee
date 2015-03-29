`import _ from 'lodash'`
`import React from 'react'`
`import Reflux from 'reflux'`
`import Actions from '../actions'`
`import SongSelectorAutocompleteStore from '../stores/songSelectorAutocompleteStore'`
`import SongSelectorRow from './SongSelectorRow'`

[songSelectorRow] = (React.createFactory(component) for component in [SongSelectorRow])
{div, input} = React.DOM

SongSelector = React.createClass
  mixins: [Reflux.connect(SongSelectorAutocompleteStore, "searchResult")]
  
  handleChange: _.debounce (->
      Actions.songSelectorAutocompleteSearch(@refs.songSearchInput.getDOMNode().value)
    ), 250
  
  render: ->
    div {},
      input type: 'text', ref: 'songSearchInput', onChange: @handleChange
      if !@state.searchResult.loaded
        div {}, "Loading"
      else if @state.searchResult.songs.length
        div {}, _.map @state.searchResult.songs, (song) ->
          songSelectorRow {key: song.videoId, song}
      else if @state.searchResult.searchTerm.length
        div {}, "No search results"
      else
        div {}, "Search for songs above"

`export default SongSelector`