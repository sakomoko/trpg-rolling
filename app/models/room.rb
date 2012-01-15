class Room
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  field :title, :type => String
  field :context, :type => String
  field :static, :type => Boolean, :default => false
  field :closed_at, :type => DateTime
end
