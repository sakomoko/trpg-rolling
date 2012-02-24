class Room
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  field :title, :type => String
  field :description, :type => String
  field :static, :type => Boolean, :default => false
  field :closed, :type => Boolean, :default => false
  field :closed_at, :type => DateTime
  attr_protected :user_id

  belongs_to :user
  belongs_to :roomable, polymorphic: true
  validates_presence_of :title, :user_id

  scope :opened, where(:closed => false)
  scope :static, where(:static => true)
  scope :closed, where(:closed => true)

  class << self

    def find_parent_model(params)
      return Session.find(params[:session_id]) if params[:session_id]
      return World.find(params[:world_id]) if params[:world_id]
      nil
    end

  end
end
