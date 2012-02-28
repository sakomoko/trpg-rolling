# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$("#new_comment_submit").button()
$("#new_comment")
  .live("ajax:beforeSend", (xhr) ->
    $("#new_comment_submit").button("loading")
  )
  .live("ajax:complete", (xhr) ->
    $("#new_comment_submit").button("reset")
  )