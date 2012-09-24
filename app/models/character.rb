class Character
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps
  include Mongoid::Versioning

  belongs_to :user
  belongs_to :game_system
  belongs_to :world

  field :name, type: String
  field :gender, type: Symbol, default: :male
  field :age, type: Integer

  validates_presence_of :name, :gender, :age
  validates_associated :user, :game_system, :world
  validates_inclusion_of :gender, in: [:male, :female]
  validates_numericality_of :age, greater_than: 0

  attr_accessible :name, :gender, :age
  attr_accessible *accessible_attributes, :user_id, :game_system_id, :world_id, :created_at, :updated_at, as: :admin
end
