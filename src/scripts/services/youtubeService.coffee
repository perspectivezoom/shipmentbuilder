`import $ from 'jquery'`
`import config from '../config'`

class YoutubeService
  search: (searchTerm) ->
    url = "https://www.googleapis.com/youtube/v3/search"
    data =
      part: 'snippet'
      q: 'karaoke' + searchTerm
      type: 'video'
      videoEmbeddable: true
      key: config.youtube.apiKey

    $.ajax
      url: url
      data: data
      crossDomain: true
      dataType: 'jsonp'
      contentType: 'application/json'
    .then (response) =>
      (@extractSong(item) for item in response.items)
  
  extractSong: (item) ->
    videoId: item.id.videoId
    title: item.snippet.title
    thumbnailUrl: item.snippet.thumbnails.default.url

`export default new YoutubeService()`