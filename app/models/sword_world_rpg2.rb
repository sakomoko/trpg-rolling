class SwordWorldRpg2 < Character

  embeds_many :acquired_skills, class_name: "SwordWorldRpg2::AcquiredSkill", inverse_of: :sword_world_rpg2
  accepts_nested_attributes_for :acquired_skills, :allow_destroy => true

  STATUS = { dexterity: [:technique, :a], agility: [:technique, :b], strength: [:physique, :c], vitality: [:physique, :d], intelligence: [:heart, :e], mind: [:heart, :f] }

  field :race, type: String
  field :birth, type: String
  field :pollution, type: Integer

  field :race_bonus, type: Array
  field :records, type: Array, default: ["", "", ""]

  field :level, type: Integer, default: 1
  field :experience, type: Integer, default: 0
  field :total_experience, type: Integer, default: 0

  field :honor, type: Integer, default: 0
  field :total_honor, type: Integer, default: 0

  field :hp_bonus, type: Integer, default: 0
  field :mp_bonus, type: Integer, default: 0

  field :technique, type: Integer, default: 0
  field :heart, type: Integer, default: 0
  field :physique, type: Integer, default: 0

  ("a".."f").each do |status|
    field "sub_#{status}".to_sym, type: Integer, default: 0
  end

  STATUS.keys.each do |status|
    field "grow_#{status}".to_sym, type: Integer, default: 0
    field "#{status}_bonus".to_sym, type: Integer, default: 0
  end

  attr_accessible :race, :birth, :pollution, :race_bonus, :records
  attr_accessible :level, :experience, :total_experience, :honor, :total_honor
  attr_accessible :hp_bonus, :mp_bonus, :technique, :heart, :physique
  attr_accessible :sub_a, :sub_b, :sub_c, :sub_d, :sub_e, :sub_f
  attr_accessible :grow_dexterity, :grow_agility, :grow_strength, :grow_vitality, :grow_intelligence, :grow_mind
  attr_accessible :dexterity_bonus, :agility_bonus, :strength_bonus, :vitality_bonus, :intelligence_bonus, :mind_bonus
  attr_accessible :acquired_skills_attributes
  attr_accessible *accessible_attributes, as: :admin

  def method_missing(method, *args)
    super unless STATUS.include? method
    status = STATUS[method]
    send("sub_#{status[1]}") + send(status[0]) + send("#{method}_bonus") + send("grow_#{method}")
  end

end
