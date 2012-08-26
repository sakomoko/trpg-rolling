class SwordWorldRpg2::Skill
  include Mongoid::Document

  field :name, type: String
  field :has_mp, type: Boolean, default: false

  validates_presence_of :name, :has_mp
  attr_accessible :name, :has_mp, as: [:default, :admin]
end
