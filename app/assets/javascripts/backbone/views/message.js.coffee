class TrpgRolling.Views.Message extends  Backbone.View
  tagName: "article"

  render: () ->
    @$el.html JST["backbone/templates/message"](@model.toJSON())
    @

class TrpgRolling.Views.Messages extends Backbone.View
  initialize: (options) ->
    @collection.on "add", @addMessage, @
    @room = options.room
    @setElement @make("div", id: "#messages-#{@room.id}")

  addMessage: (message) ->
    view = new TrpgRolling.Views.Message
      model: message
    @$el.prepend view.render().el

  render: () ->
    $("#chat-container").append @el
    @

class TrpgRolling.Views.sendMessage extends Backbone.View
  el: "#input"
  events:
    "click button": "sendMessage"

  initialize: (options) ->
    @app = options.app
    @$input = @$el.find("input")

  sendMessage: (evt) ->
    console.log "send!!"
    message = @$input.val()
    evt.preventDefault()
    @app.handlers.trigger "send-message", @app.currentRoom, body: message, =>
      @$input.val ""

