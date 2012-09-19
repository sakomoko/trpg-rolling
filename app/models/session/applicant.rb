class Session::Applicant
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :session
  belongs_to :character

  field :status, type: Symbol, default: :entry

  validates_presence_of :character_id
  validates_inclusion_of :status, in: [:entry, :approved]

  attr_accessible :character_id, :status, as: :admin
end
