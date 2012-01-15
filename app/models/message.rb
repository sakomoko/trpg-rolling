class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, :type => String
  field :supplement, :type => String
  field :dice, :type => Hash
  field :alias, :type => Hash

  belongs_to :user
  belongs_to :room
end
