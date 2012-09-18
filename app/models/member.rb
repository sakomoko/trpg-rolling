class Member
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :world
  belongs_to :user

  field :status, type: Symbol, default: :approved

  validates_inclusion_of :status, in: [:approved, :awaiting]

  attr_accessible :user, :status, as: :admin

  scope :approved, where(status: :approved)
  scope :awaiting, where(status: :awaiting)
end
