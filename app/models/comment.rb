class Comment
  include Mongoid::Document
  field :body, :type => String

  belongs_to :user
  embedded_in :commentable, polymorphic: true

  attr_protected :user_id
end
