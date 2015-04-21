`import _ from 'lodash'`
`import $ from 'jquery'`
`import React from 'react'`
`import Reflux from 'reflux'`
`import YoutubePlayer from 'react-youtube'`
`import config from '../config'`
`import Actions from '../actions'`
`import PlayerStore from '../stores/playerStore'`
`import PlayerBlankSlate from './playerBlankSlate'`
`import PlaylistSongs from './playlistSongs'`

{div, button, i, text} = React.DOM
[youtubePlayer, playerBlankSlate, playlistSongs] = (React.createFactory(component) for component in [YoutubePlayer, PlayerBlankSlate, PlaylistSongs])

Player = React.createClass
  mixins: [Reflux.connect(PlayerStore, "player")]
  
  componentDidMount: ->
    Actions.playlistSlugChange @props.params.playlistSlug
  
  handleNextClick: _.debounce (->
      Actions.playerAdvanceSong()
    ), 500, leading: true, trailing: false

  playerWidth: ->
    $(window).width()

  playerHeight: ->
    @playerWidth() * 9 / 16

  youtubePlayerOptions: ->
    url: "#{config.youtube.videoUrl}#{@state.player.currentSong.videoId}"
    onEnd: Actions.playerAdvanceSong
    opts:
      width: @playerWidth()
      height: @playerHeight()
      playerVars:
        autohide: 1
        autoplay: 1
        modestbranding: 1
        iv_load_policy: 3
  
  render: ->
    div {},
      if !@state.player.loaded
        playerBlankSlate message: "Loading..."
      else if @state.player.currentSong
        div {},
          youtubePlayer @youtubePlayerOptions()
          div {},
            button className: "button", onClick: @handleNextClick,
              i className: "fa fa-forward"
              text {}, "Next"

      else
        playerBlankSlate message: "No Songs"
      playlistSongs {}

`export default Player`