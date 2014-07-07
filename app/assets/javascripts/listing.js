
$(document).ready(func = function() {

  // TODO: below is a hack to deal with gallery and listings
  // loading together when turbolinks is enabled
  if (location.pathname.match( /^\/listing/ )) {
    // remove all previous breadcrumbs
    $('#breadcrumbs').html(
      "<span class='breadcrumb'>/ gallery</span>"
    )

    referer = localStorage.getItem( 'gallery-referrer' )

    // check if referer is from gallery, if the case, we will
    // build breadcrumbs from path
    if (referer && referer.match( /^\/gallery/ )) {

      // remove gallery from path and seperate out
      // path nodes
      tags      = referer.replace( '/gallery/', '' ).split( '/' )
      container = $("#breadcrumbs") 

      for(counter = 0; counter < tags.length; counter++) {
        href = '/gallery/' + tags.slice(0, counter + 1).join( '/' )
        container.append(
          " / <span class='breadcrumb' >"      + 
          "<a href='" + href + "' >"        +
            tags[counter].replace( '-', ' ') +
          "</a></span>"
        )
      }
    }
  }
  
  setTimeout(function() {
    $(window).bind( 'page:change', func )
    func = null
  })

})