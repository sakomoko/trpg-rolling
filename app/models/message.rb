class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, :type => String
  field :supplement, :type => String
  field :dice, :type => Hash
  field :alias, :type => Hash

  belongs_to :user
  belongs_to :room
  validates_presence_of :user, :room, :body

  attr_accessible :body, :supplement, :alias
  attr_accessible *accessible_attributes, :dice, :user_id, :room_id, :created_at, :updated_at, as: :admin
end
