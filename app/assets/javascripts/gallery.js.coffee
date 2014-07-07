# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready func = ->
  # TODO: below is a hack to deal with gallery and listings
  # loading together when turbolinks is enabled
  if location.pathname.match /^\/gallery/
    # set last pathname, which will be used on listing page
    localStorage.setItem "gallery-referrer", location.pathname

    setTimeout ->
      $(window).bind "page:change", func
      func = null
      return