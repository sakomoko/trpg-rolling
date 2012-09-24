class Session::Applicant
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :session
  belongs_to :character

  field :status, type: Symbol, default: :entry
  field :comment, type: String
  field :version, type: Integer

  validates_presence_of :character_id, :version
  validates_inclusion_of :status, in: [:entry, :approved]

  attr_accessible :comment
  attr_accessible :comment, :character_id, :status, :version, as: :admin

  scope :approved, where(status: :approved)

  def approved?
    status == :approved
  end
end
