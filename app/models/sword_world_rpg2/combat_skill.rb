class SwordWorldRpg2::CombatSkill
  include Mongoid::Document

  has_and_belongs_to_many :characters, class_name: "SwordWorldRpg2"

  field :name, type: String
  field :description, type: String

  validates_presence_of :name, :description
  validates_uniqueness_of :name

  attr_accessible :name, :description, :character_ids,  as: :admin
end
