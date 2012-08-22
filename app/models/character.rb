class Character
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :game_system
  belongs_to :world

  field :name, type: String
  field :sex, type: Integer
  field :age, type: Integer

  attr_accessible :name, :sex, :age
  attr_accessible *accessible_attributes, :user_id, :game_system_id, :world_id, :created_at, :updated_at, as: :admin
end
