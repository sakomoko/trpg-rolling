require 'spec_helper'
require "cancan/matchers"

describe GameSystem do
  describe "ability" do
    subject { ability }
    let(:ability) { Ability.new(user) }

    context "When editing by admin" do
      let(:user) { Factory :user, :role => 'admin' }
      it { should be_able_to(:manage, GameSystem.new)}
    end

  end
end
