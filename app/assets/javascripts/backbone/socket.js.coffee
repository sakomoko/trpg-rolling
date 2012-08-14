class TrpgRolling.Socket
  constructor: (@app) ->
    @connect()
    @addHandlers()
    @addSocketHandlers()

  connect: =>
    @url = "localhost"
    @options =
      port: 5000
    @socket = io.connect @url, @options

  addHandlers: () ->
    @app.handlers.on "add-room", @connectRoom, @
    @app.handlers.on "request-join-user", @joinUser, @
    @app.handlers.on "send-message", @sendMessage, @

  addSocketHandlers: () ->
    @socket.on "connect", () =>
      console.log "io connection connected!"
      @app.handlers.trigger "load-first-room"

    @socket.on 'updateJoinedMembers', (roomId, members) =>
      @app.handlers.trigger "update-joined-members", roomId, members
      console.log "update joinedmember!"

    @socket.on "pushMessage", (roomId, msg) =>
      @app.handlers.trigger "receive-message", roomId, msg

    @socket.on "pushJoinedMember", (roomId, member) =>
      @app.handlers.trigger "receive-joined-member", roomId, member

    @socket.on "pushLeaveMember", (roomId, member) =>
      @app.handlers.trigger "receive-leave-member", roomId, member

  joinUser: (info, currentRoom) =>
    @socket.emit "joinMember", currentRoom, info, =>
      console.log "success joined"
      @app.handlers.trigger "join-user"

  connectRoom: (room) ->
    @socket.emit 'connectRoom', room.id, () =>
      console.log "connect success. room #{room.id}, title=#{room.get('title')}"
      @socket.emit 'getJoinedMembers', room.id
      @socket.emit "getRoomLog", room.id

  sendMessage: (roomId, msg, cb) ->
    @socket.emit "sendMessage", roomId, msg, cb