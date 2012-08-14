#= require ./socket

class TrpgRolling.ChatApp extends Backbone.View
  el: "body"
  events:
    "click #join": "fetchUserInfo"

  initialize: () ->
    @handlers = _.extend({}, Backbone.Events)
    @socket = new TrpgRolling.Socket(@)

    @addHandlers()
    @roomsView = new TrpgRolling.Views.Rooms
      app: @

  fetchUserInfo: (e) ->
    @currentRoom = $(e.target).parents().find("a").data("id")
    $.ajax
      url: "/user.json"
      success: (info) =>
        @handlers.trigger "request-join-user", info, @currentRoom
    e.preventDefault()

  loadFirstRoom: () ->
    @roomsView.collection.add @firstLoad

  joinedFirstRoom: () ->
    @sendMessageView = new TrpgRolling.Views.sendMessage
      app: @

  addHandlers: () ->
    @handlers.on "load-first-room", @loadFirstRoom, @

    @handlers.on "join-user", () =>
      $(".form-actions").hide()
      $("#input").show()
      @joinedFirstRoom() unless @sendMessageView
    , @
