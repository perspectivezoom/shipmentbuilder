`import _ from 'lodash'`
`import React from 'react'`
`import Reflux from 'reflux'`
`import Actions from '../actions'`
`import SongSelectorAutocompleteStore from '../stores/songSelectorAutocompleteStore'`
`import SongSelectorRow from './songSelectorRow'`
`import SongSelectorBlankSlate from './songSelectorBlankSlate'`

[songSelectorRow, songSelectorBlankSlate] = (React.createFactory(component) for component in [SongSelectorRow, SongSelectorBlankSlate])
{div, input} = React.DOM

SongSelector = React.createClass
  mixins: [Reflux.connect(SongSelectorAutocompleteStore, "searchResult")]
  
  handleChange: _.debounce (->
      Actions.songSelectorAutocompleteSearch(@refs.songSearchInput.getDOMNode().value)
    ), 250
  
  render: ->
    div className: "song-selector",
      input type: 'text', ref: 'songSearchInput', onChange: @handleChange, className: "song-selector__input"
      div {},
        if !@state.searchResult.loaded
          songSelectorBlankSlate message: "Loading..."
        else if @state.searchResult.songs.length
          _.map @state.searchResult.songs, (song) ->
            songSelectorRow {key: song.videoId, song}
        else if @state.searchResult.searchTerm.length
          songSelectorBlankSlate message: "No search results"
        else
          songSelectorBlankSlate message: "Search for songs above"

`export default SongSelector`