class TrpgRolling.Views.Room extends Backbone.View
  tagName: "li"

  initialize: () ->
    @members = new TrpgRolling.Views.Users
      collection: @model.members
      room: @model
      el: "#users-nav-#{@model.id}"

    @messages = new TrpgRolling.Views.Messages
      collection: @model.messages
      room: @model

    @members.render()
    @messages.render()

  render: () ->
    @$el.html JST["backbone/templates/rooms_list"](@model.toJSON())

class TrpgRolling.Views.Rooms extends Backbone.View
  el: "#rooms-nav"

  initialize: (options) ->
    @app = options.app
    @collection = new TrpgRolling.Collections.RoomsCollection()
    @collection.on "add", @addRoom, @
    @addHandlers()

  addHandlers: () ->
    @app.handlers.on "update-joined-members", @updateJoinedMembers, @
    @app.handlers.on "receive-joined-member", @receiveJoinedMember, @
    @app.handlers.on "receive-leave-member", @receiveLeaveMember, @
    @app.handlers.on "receive-message", @receiveMessage, @

  addRoom: (room) ->
    @app.handlers.trigger "add-room", room
    view = new TrpgRolling.Views.Room
      model: room
    @$el.append view.render()

  updateJoinedMembers: (roomId, members) ->
    @collection.get(roomId).members.add members

  receiveJoinedMember: (roomId, member) ->
    @collection.get(roomId).members.add member

  receiveLeaveMember: (roomId, member) ->
    model = @collection.get(roomId).members.get(member._id)
    @collection.get(roomId).members.remove model

  receiveMessage: (roomId, msg) ->
    @collection.get(roomId).messages.add msg
