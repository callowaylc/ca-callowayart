
$(document).ready(lfunc = function() {

  // TODO: below is a hack to deal with gallery and listings
  // loading together when turbolinks is enabled
  if (location.pathname.match( /^\/listing/ )) {

    // reset content in breadcrumbs
    $('#breadcrumbs').html('')

    referer = localStorage.getItem( 'gallery-referrer' )

    // check if referer is from gallery, if the case, we will
    // build breadcrumbs from path
    if (referer && (match = referer.match( /^\/(gallery|search)/ )[1])) {

      // remove all previous breadcrumbs
      $('#breadcrumbs').html(
        "<span class='breadcrumb'>/ " + match + "</span>"
      )
      // remove gallery from path and seperate out
      // path nodes
      resource  = '/' + match + '/'
      tags      = referer.replace( resource, '' ).split( '/' )
      container = $("#breadcrumbs") 

      for(counter = 0; counter < tags.length; counter++) {
        href = resource + tags.slice(0, counter + 1).join( '/' )
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
    $(window).bind( 'page:change', lfunc )
    lfunc = null
  })

})