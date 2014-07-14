$(document).ready func = ->
  # TODO: below is a hack to deal with gallery and listings
  # loading together when turbolinks is enabled
  if location.pathname.match /^\/search/
    # set last pathname, which will be used on listing page
    localStorage.setItem "gallery-referrer", 

    setTimeout ->
      $(window).bind "page:change", getParameterByName "q"
      func = null
      return