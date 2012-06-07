# Variables for the tests.
url = "http://georgia.gov"
breakpoints = [
  [1280, 1024],
  [960, 640],
  [480, 320]
]
links = [
  "/",
  "/search?query=georgia",
  "/agency-list",
  "/environment",
]

casper = require('casper').create({
  #verbose: true,
  logLevel: "debug",
})

casper.test.comment "#{url} - Screenshots to test responsive breakpoints"

casper.start()

# Needed so that the first screenshot works, sadly.
casper.then ->
  @viewport breakpoints[0][0], breakpoints[0][1]
  @open url + links[0]
  @echo "Opening URL #{url + links[0]}."
  @wait 2000

openPages = ->
  @each links, (self, link) ->
    fullUrl = url + link
    # Open a URL.
    @thenOpen fullUrl, ->
      @test.assertHttpStatus 200, "URL #{fullUrl} was found."
      # Capture an image.
      @capture fullUrl.replace(/[^a-zA-Z0-9]/gi,'-').replace(/^https?-+/, '') + breakpoints[currentBreakpoint - 1][0] + ".png"

currentBreakpoint = 0

check = ->
  if breakpoints[currentBreakpoint]
    @viewport breakpoints[currentBreakpoint][0], breakpoints[currentBreakpoint][1]
    openPages.call @
    currentBreakpoint++
    @run check
  else
    @echo "All done."
    @test.renderResults true
    @exit

casper.run check

