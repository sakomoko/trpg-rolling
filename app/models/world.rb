class World
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  belongs_to :owner, class_name: "User", inverse_of: :own_world
  belongs_to :game_system
  has_many :rooms

  field :name, :type => String
  field :description, :type => String
  field :open, :type => Boolean, :default => true
  field :latest_session, :type => DateTime
  attr_protected :owner

  validates_presence_of :name, :owner, :game_system

end
