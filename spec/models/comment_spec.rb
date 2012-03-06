require 'spec_helper'

describe Comment do
  describe "attr_accesible" do
    it { should be_accessible :body }

    it { should_not be_accessible :id }
    it { should_not be_accessible :user_id }

    it { should_not be_accessible :created_at }
    it { should_not be_accessible :updated_at }
  end

end
