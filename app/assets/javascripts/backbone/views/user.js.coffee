class TrpgRolling.Views.User extends Backbone.View
  tagName: "li"

  initialize: () ->
    @model.on "remove", @remove, @

  render: () ->
    @$el.html JST["backbone/templates/users_list"](@model.toJSON())


class TrpgRolling.Views.Users extends Backbone.View

  initialize: (options) ->
    @room = options.room
    @collection.on "add", @addUser, @
    @collection.on "remove", @removeUser, @

  changeUserCount: () ->
    $("#num-users-#{@room.id}").text(@collection.length)

  addUser: (user) ->
    @changeUserCount()
    view = new TrpgRolling.Views.User
      model: user
    @$el.append view.render()

  removeUser: () ->
    @changeUserCount()