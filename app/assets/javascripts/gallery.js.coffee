# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  if location.pathname.match /^\/gallery/
    func = ->
      if location.pathname.match /^\/gallery/
        # TODO: below is a hack to deal with gallery and listings
        # loading together when turbolinks is enabled
        # set last pathname, which will be used on listing page
        localStorage.setItem "gallery-referrer", location.pathname
        return

    # call func and attach to page:change event
    func()

    setTimeout ->
      $(document).bind "page:change", func
      return