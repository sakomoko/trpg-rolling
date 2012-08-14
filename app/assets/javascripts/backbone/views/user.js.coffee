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

  addUser: (user) ->
    $("#num-users-#{@room.id}").text(@collection.length)
    view = new TrpgRolling.Views.User
      model: user
    @$el.append view.render()
