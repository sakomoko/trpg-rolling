require 'spec_helper'

describe Message do
    describe "attr_accesible" do
    it { should be_accessible :body }
    it { should be_accessible :supplement }
    it { should be_accessible :alias }

    it { should_not be_accessible :id }
    it { should_not be_accessible :user_id }
    it { should_not be_accessible :room_id }

    it { should_not be_accessible :dice }
    it { should_not be_accessible :created_at }
    it { should_not be_accessible :updated_at }
  end
end
