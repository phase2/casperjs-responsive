casper = require('casper').create({
  verbose: true,
  logLevel: "debug"
})

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
  #"/agency-list",
  #"/environment",
]

casper.start()

casper.each links, (self, link) ->
  fullUrl = url + link
  # Reset the viewport.
  @viewport breakpoints[0][0], breakpoints[0][1]
  @thenOpen fullUrl, ->
    # Reset the viewport.
    @viewport breakpoints[0][0], breakpoints[0][1]
    @test.assertHttpStatus 200, "#{link} was found."
    @each breakpoints, (self, breakpoint) ->
      @viewport breakpoint[0], breakpoint[1]
      @capture fullUrl.replace(/[^a-zA-Z0-9]/gi,'-').replace(/^https?-+/, '') + breakpoint[0] + ".png"

casper.run ->
  # Show the test results.
  @test.renderResults true
