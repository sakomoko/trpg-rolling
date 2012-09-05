class SwordWorldRpg2::Ability
  include Mongoid::Document

  embedded_in :character, class_name: "SwordWorldRpg2", inverse_of: :abilities

  field :name, type: String
  field :description, type: String

  validates_presence_of :name

  attr_accessible :name, :description, as: [:default, :admin]
end
