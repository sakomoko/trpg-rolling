class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, :type => String

  belongs_to :user
  embedded_in :commentable, polymorphic: true, inverse_of: :comments

  validates_presence_of :body

  attr_accessible :body
  attr_accessible *accessible_attributes, :user_id, as: :admin
end
