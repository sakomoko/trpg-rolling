class Session
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes

  belongs_to :world
  belongs_to :game_master, class_name: "User"
  has_many :rooms, as: :roomable
  embeds_many :comments, as: :commentable

  field :title, :type => String
  field :description, :type => String

  field :started_at, :type => DateTime
  field :finished_at, :type => DateTime

  field :guidelines, :type => String

  field :open, :type => Boolean, :default => true
  field :published, :type => Boolean, :default => true
  field :finished, :type => Boolean, :default => false

  validates_presence_of :title, :description, :game_master_id, :world_id

  scope :finished, where(:finished => true)
  scope :playing, where(:finished => false)

  attr_accessible :title, :description, :started_at, :finished_at, :guidelines, :published

  alias :owner :game_master
end
