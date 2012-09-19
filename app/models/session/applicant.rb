class Session::Applicant
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :session
  belongs_to :character

  field :status, type: Symbol, default: :entry
  field :comment, type: String

  validates_presence_of :character_id
  validates_inclusion_of :status, in: [:entry, :approved]

  attr_accessible :comment
  attr_accessible :comment, :character_id, :status, as: :admin

  scope :approved, where(status: :approved)

  def approved?
    status == :approved
  end
end
