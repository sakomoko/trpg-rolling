class SwordWorldRpg2::AcquiredSkill
  include Mongoid::Document

  embedded_in :character, class_name: "SwordWorldRpg2", inverse_of: :acquired_skills
  belongs_to :skill, class_name: "SwordWorldRpg2::Skill", inverse_of: :acquired_skills
  field :level, type: Integer, default: 1

  validates_presence_of :level, :skill_id

  attr_accessible :level, :skill_id, as: [:default, :admin]
end
