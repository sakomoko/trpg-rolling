class TrpgRolling.Models.Room extends Backbone.Model
  paramRoot: 'room'
  idAttribute: "_id"

  initialize: () ->
    @members = new TrpgRolling.Collections.UsersCollection()
    @messages = new TrpgRolling.Collections.MessagesCollection()

class TrpgRolling.Collections.RoomsCollection extends Backbone.Collection
  model: TrpgRolling.Models.Room
  url: '/rooms'
