class Session
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes

  belongs_to :world
  belongs_to :game_master, class_name: "User"
  has_many :rooms, as: :roomable, inverse_of: :roomable
  embeds_many :comments, as: :commentable, inverse_of: :commentable
  embeds_many :applicants, class_name: "Session::Applicant"

  accepts_nested_attributes_for :comments, :allow_destroy => true
  accepts_nested_attributes_for :applicants, :allow_destroy => true

  field :title, :type => String
  field :description, :type => String
  field :guidelines, :type => String
  field :public, :type => Boolean, :default => true

  field :started_at, :type => DateTime
  field :finished_at, :type => DateTime
  field :finished, :type => Boolean, :default => false
  field :closed_at, :type => DateTime
  field :deadline, :type => DateTime
  field :fix_applicant, :type => Boolean, :default => false

  validates_presence_of :title, :description, :game_master_id, :world_id, :started_at, :finished_at

  scope :finished, where(:finished => true)
  scope :playing, where(:finished => false)

  attr_accessible :title, :description, :started_at, :finished_at, :guidelines, :public, :deadline, :fix_applicant
  attr_accessible :comments_attributes
  attr_accessible *accessible_attributes, :applicants_attributes, :world_id, :game_master_id, :finished, :closed_at, :created_at, :updated_at, as: :admin

  alias :owner :game_master
end
