class World
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  belongs_to :owner, class_name: "User"
  belongs_to :game_system
  has_many :rooms, as: :roomable, inverse_of: :roomable
  has_many :sessions
  has_many :characters
  embeds_many :members

  accepts_nested_attributes_for :members

  field :name, :type => String
  field :description, :type => String
  field :public, :type => Boolean, :default => true
  field :latest_session_at, :type => DateTime

  validates_presence_of :name, :description, :public, :owner_id, :game_system_id

  attr_accessible :name, :description, :public, :game_system_id
  attr_accessible *accessible_attributes, :owner_id, :latest_session_at, :created_at, :updated_at, :deleted_at, as: :admin

  alias :title :name

  def user_joined?(user)
    members.approved.where(user: user).exists?
  end

  def user_awaiting?(user)
    members.awaiting.where(user: user).exists?
  end

  def register(user)
    if can_user_register? user
      member = Member.new({ status: :awaiting, user: user}, as: :admin)
      members << member
      member
    end
  end

  def join(user)
    if !user_joined? user
      if user_awaiting? user
        member = members.where(user: user).first
        member.update_attributes({status: :approved}, as: :admin)
      else
        members << Member.new({user: user, status: :approved}, as: :admin)
      end
    end
  end

  def can_user_register?(user)
    !user_awaiting?(user) && !user_joined?(user)
  end
end
