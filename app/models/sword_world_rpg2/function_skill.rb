class SwordWorldRpg2::FunctionSkill
  include Mongoid::Document
  embedded_in :character, class_name: "SwordWorldRpg2", inverse_of: :function_skills

  field :name, type: String
  field :level, type: Integer, default: 1

  validates_presence_of :name, :level
  attr_accessible :name, :level, as: [:default, :admin]
end
