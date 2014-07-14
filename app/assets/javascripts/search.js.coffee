$(document).ready sfunc = ->
  # TODO: below is a hack to deal with gallery and listings
  # loading together when turbolinks is enabled
  if location.pathname.match /^\/search/
    # set last pathname, which will be used on listing page
    localStorage.setItem "gallery-referrer", location.pathname

    setTimeout ->
      $(window).bind "page:change", sfunc
      sfunc = null
      return