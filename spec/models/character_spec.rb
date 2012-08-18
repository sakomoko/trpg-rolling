require 'spec_helper'

describe Character do
  describe "attr_accesible" do
    it { should be_accessible :name }
    it { should be_accessible :sex }
    it { should be_accessible :age }

    it { should_not be_accessible :user_id }
    it { should_not be_accessible :game_system_id }
    it { should_not be_accessible :world_id }
  end

  describe "admin attr_accesible" do
    it { should be_admin_accessible :name }
    it { should be_admin_accessible :sex }
    it { should be_admin_accessible :age }

    it { should be_admin_accessible :user_id }
    it { should be_admin_accessible :game_system_id }
    it { should be_admin_accessible :world_id }
    it { should be_admin_accessible :created_at }
    it { should be_admin_accessible :updated_at }
  end
end
