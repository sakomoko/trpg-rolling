class World
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  belongs_to :owner, class_name: "User"
  belongs_to :game_system
  has_many :rooms, as: :roomable
  has_many :sessions

  field :name, :type => String
  field :description, :type => String
  field :open, :type => Boolean, :default => true
  field :latest_session_at, :type => DateTime

  validates_presence_of :name, :owner_id, :game_system_id

  attr_accessible :name, :description, :open, :game_system_id

  alias :title :name
end
