$(document).ready func = ->
  # TODO: below is a hack to deal with gallery and listings
  # loading together when turbolinks is enabled
  alert "dfd"
  if location.pathname.match /^\/search/
  	alert "adsf"
    # set last pathname, which will be used on listing page
    localStorage.setItem "gallery-referrer", location.pathname

    setTimeout ->
      $(window).bind "page:change", func
      func = null
      return