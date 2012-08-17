class Room
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  field :title, :type => String
  field :description, :type => String
  field :static, :type => Boolean, :default => false
  field :closed, :type => Boolean, :default => false
  field :closed_at, :type => DateTime

  belongs_to :user
  belongs_to :roomable, polymorphic: true, inverse_of: :rooms
  validates_presence_of :title, :user_id

  scope :opened, where(:closed => false)
  scope :static, where(:static => true)
  scope :closed, where(:closed => true)

  attr_accessible :title, :description, :static
  attr_accessible *accessible_attributes, :user_id, :roomable_id,:roomable_type, :closed, :closed_at, as: :admin

  class << self

    def find_parent_model(params)
      return Session.find(params[:session_id]) if params[:session_id]
      return World.find(params[:world_id]) if params[:world_id]
      nil
    end

  end
end
