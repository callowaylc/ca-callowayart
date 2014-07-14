// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery-fileupload

$(document).ready(func = function() {

  $('#search').click(search = function() {
    if ((val = $('#q').val())) {
      location.href = '/search/' + encodeURIComponent(val)
    }
  })

  $('#q').keypress(function(e) {
    if(e.which == 13) {
      search()
    }
  })


  if (location.pathname.match(/^\/(gallery|search)/)) {
    localStorage.setItem("gallery-referrer", location.pathname)
  }

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


  
})
setTimeout(function() {
  $(window).bind( 'page:change', func )
})

function getParameterByName(name) {
  name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
  var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
      results = regex.exec(location.search);
  return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}