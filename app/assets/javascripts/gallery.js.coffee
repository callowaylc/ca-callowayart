# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  # set last pathname, which will be used on listing page
  alert location.pathname
  localStorage.setItem "gallery-referrer", location.pathname
  return
