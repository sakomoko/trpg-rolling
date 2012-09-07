class GameSystem
  include Mongoid::Document

  has_many :characters
  has_many :worlds

  field :name, :type => String
  field :description, :type => String
  field :system_key, :type => String, default: ->{ name }
  validates_presence_of :name, :system_key
  validates_uniqueness_of :name, :system_key

  attr_accessible :name, :description, :system_key
  attr_accessible *accessible_attributes, as: :admin
end
