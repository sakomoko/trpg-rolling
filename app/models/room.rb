class Room
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  field :title, :type => String
  field :description, :type => String
  field :static, :type => Boolean, :default => false
  field :closed, :type => Boolean, :default => false
  field :closed_at, :type => DateTime
  attr_protected :user

  belongs_to :user
  belongs_to :roomable, polymorphic: true
  validates_presence_of :title, :user
end
