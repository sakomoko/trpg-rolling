class SwordWorldRpg2::Skill
  include Mongoid::Document

  field :name, type: String
  field :has_mp, type: Boolean, default: false

  validates_presence_of :name
  attr_accessible :name, :has_mp, as: [:default, :admin]

  class << self
    def create_seed_data
      skills = YAML.load_file "#{Rails.root}/db/seeds/sword_world_rpg2/skills.yml"
      self.delete_all
      skills.each do |skill|
        self.create! skill, as: :admin
      end
    end
  end
end
