class SwordWorldRpg2 < Character
  has_and_belongs_to_many :combat_skills, class_name: "SwordWorldRpg2::CombatSkill"
  embeds_many :acquired_skills, class_name: "SwordWorldRpg2::AcquiredSkill"
  embeds_many :abilities, class_name: "SwordWorldRpg2::Ability"
  embeds_many :function_skills, class_name: "SwordWorldRpg2::FunctionSkill"
  accepts_nested_attributes_for :acquired_skills, :abilities, :function_skills, :allow_destroy => true

  STATUS = { dexterity: [:technique, :a], agility: [:technique, :b], strength: [:physique, :c], vitality: [:physique, :d], intelligence: [:heart, :e], mind: [:heart, :f] }

  field :race, type: String
  field :birth, type: String
  field :pollution, type: Integer

  field :race_bonus, type: String
  field :records, type: Array, default: ["", "", ""]

  field :experience, type: Integer, default: 0
  field :total_experience, type: Integer, default: 0

  field :honor, type: Integer, default: 0
  field :total_honor, type: Integer, default: 0

  field :hp_bonus, type: Integer, default: 0
  field :mp_bonus, type: Integer, default: 0

  field :technique, type: Integer, default: 0
  field :heart, type: Integer, default: 0
  field :physique, type: Integer, default: 0

  field :equipments, type: String
  field :items, type: String
  field :honor_items, type: String

  field :profile, type: String
  field :memo, type: String

  ("a".."f").each do |status|
    field "sub_#{status}".to_sym, type: Integer, default: 0
  end

  STATUS.keys.each do |status|
    field "grow_#{status}".to_sym, type: Integer, default: 0
    field "#{status}_equipment".to_sym, type: Integer, default: 0
  end

  attr_accessible :race, :birth, :pollution, :race_bonus, :records
  attr_accessible :experience, :total_experience, :honor, :total_honor
  attr_accessible :hp_bonus, :mp_bonus, :technique, :heart, :physique
  attr_accessible :sub_a, :sub_b, :sub_c, :sub_d, :sub_e, :sub_f
  attr_accessible :grow_dexterity, :grow_agility, :grow_strength, :grow_vitality, :grow_intelligence, :grow_mind
  attr_accessible :dexterity_equipment, :agility_equipment, :strength_equipment, :vitality_equipment, :intelligence_equipment, :mind_equipment
  attr_accessible :equipments, :items, :honor_items, :profile, :memo
  attr_accessible :acquired_skills_attributes, :abilities_attributes, :function_skills_attributes
  attr_accessible :combat_skill_ids
  attr_accessible *accessible_attributes, as: :admin

  def method_missing(method, *args)
    if method.to_s.include? "bonus"
      status, * = method.to_s.split("_")
      super unless status.to_sym.in? STATUS.keys
      (send(status) / 6).truncate
    else
      super unless STATUS.include? method
      status = STATUS[method]
      send("sub_#{status[1]}") + send(status[0]) + send("#{method}_equipment") + send("grow_#{method}")
    end
  end

  def level
    acquired_skills.max(:level)
  end

  def hp
    3 * level + vitality + hp_bonus
  end
end
