`import _ from 'lodash'`
`import React from 'react'`
`import Reflux from 'reflux'`
`import YoutubePlayer from 'react-youtube'`
`import config from '../config'`
`import Actions from '../actions'`
`import PlayerStore from '../stores/playerStore'`
`import PlaylistSongs from './playlistSongs'`

{div, button} = React.DOM
[youtubePlayer, playlistSongs] = (React.createFactory(component) for component in [YoutubePlayer, PlaylistSongs])

Player = React.createClass
  mixins: [Reflux.connect(PlayerStore, "player")]
  
  componentDidMount: ->
    Actions.playlistSlugChange @props.params.playlistSlug
  
  handleNextClick: _.debounce (->
      Actions.playerAdvanceSong()
    ), 500, leading: true, trailing: false

  youtubePlayerOptions: ->
    url: "#{config.youtube.videoUrl}#{@state.player.currentSong.videoId}"
    onEnd: Actions.playerAdvanceSong
    opts:
      playerVars:
        autoplay: 1
  
  render: ->
    div {},
      if !@state.player.loaded
        div {}, "Loading"
      else if @state.player.currentSong
        div {},
          button onClick: @handleNextClick, "Next"
          youtubePlayer @youtubePlayerOptions()

      else
        div {}, "No Songs"
      playlistSongs {}

`export default Player`