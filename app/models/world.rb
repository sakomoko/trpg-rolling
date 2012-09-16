class World
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  belongs_to :owner, class_name: "User"
  belongs_to :game_system
  has_many :rooms, as: :roomable, inverse_of: :roomable
  has_many :sessions
  has_many :characters

  field :name, :type => String
  field :description, :type => String
  field :public, :type => Boolean, :default => true
  field :latest_session_at, :type => DateTime

  validates_presence_of :name, :description, :public, :owner_id, :game_system_id

  attr_accessible :name, :description, :public, :game_system_id
  attr_accessible *accessible_attributes, :owner_id, :latest_session_at, :created_at, :updated_at, :deleted_at, as: :admin

  alias :title :name
end
