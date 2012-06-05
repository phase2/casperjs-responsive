casper = require('casper').create()

casper.start "http://georgia.gov", ->
  # Resize the viewport.
  @viewport 1280, 1024

casper.then ->
  # Take a picture.
  @wait 1
  @capture 'georgia12801024.jpg'
  @viewport 1024, 768
  # Take a picture.
  @wait 1
  @capture 'georgia1024768.jpg'
  @viewport 960, 640
  # Take a picture.
  @wait 1
  @capture 'georgia960640.jpg'
  @viewport 480, 320
  # Take a picture.
  @wait 1
  @capture 'georgia480320.jpg'

casper.run ->
  # Show the test results.
  @test.renderResults true

