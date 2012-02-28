class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, :type => String

  belongs_to :user
  embedded_in :commentable, polymorphic: true

  attr_protected :user_id

  validates_presence_of :body
end
