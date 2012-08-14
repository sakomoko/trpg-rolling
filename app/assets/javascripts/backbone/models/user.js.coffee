class TrpgRolling.Models.User extends Backbone.Model
  defaults:
    isMe: no
  idAttribute: "_id"

class TrpgRolling.Collections.UsersCollection extends Backbone.Collection
  model: TrpgRolling.Models.User
