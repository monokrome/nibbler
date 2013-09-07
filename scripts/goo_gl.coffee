# Description:
#   Quick description for goo.gl URLs
#
# Dependencies:
#   None
#
# Commands:
#   shows the destination of goo.gl URLs

googleapis = require 'googleapis'

module.exports = (robot) ->
  shortener = googleapis.discover 'urlshortener', 'v1'

  urlReceived = (msg, url) -> (err, response) ->
    unless err
      msg.send 'Shortened URL (' + url + ') is ' + response.longUrl

  shortener.execute (err, client) ->
    robot.hear /goo\.gl\/[\w\d]+/, (msg) ->
      for url in msg.match
        url = msg.match

        request = client.urlshortener.url.get
          shortUrl: 'http://' + url

        request.execute urlReceived msg, url
