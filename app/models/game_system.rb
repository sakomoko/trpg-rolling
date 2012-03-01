class GameSystem
  include Mongoid::Document
  field :name, :type => String
  field :description, :type => String

  validates_presence_of :name
  validates_uniqueness_of :name
end
