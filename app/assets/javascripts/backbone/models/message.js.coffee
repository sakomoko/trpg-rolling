class TrpgRolling.Models.Message extends Backbone.Model
  defaults:
    body: null

class TrpgRolling.Collections.MessagesCollection extends Backbone.Collection
  model: TrpgRolling.Models.Message

  comparator: (model) ->
    model.get("_id")
