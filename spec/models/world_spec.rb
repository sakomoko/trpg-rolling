require 'spec_helper'
require "cancan/matchers"

describe World do

  describe "associations" do
    it { should belong_to(:owner).of_type(User) }
    it { should belong_to(:game_system) }
    it { should have_many(:rooms).as_inverse_of(:roomable) }
    it { should have_many(:sessions) }
    it { should have_many(:characters) }
  end

  describe "fields" do
    it { should have_fields(:name, :description).of_type(String) }
    it { should have_field(:public).of_type(Boolean).with_default_value_of(true) }
    it { should have_field(:latest_session_at).of_type(DateTime) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :public }

    it { should validate_presence_of :owner_id }
    it { should validate_presence_of :game_system_id }
  end


  describe "attr_accesible" do
    it { should be_accessible :name }
    it { should be_accessible :description }
    it { should be_accessible :public }
    it { should be_accessible :game_system_id }

    it { should_not be_accessible :id }
    it { should_not be_accessible :owner_id }
    it { should_not be_accessible :latest_session_at }

    it { should_not be_accessible :created_at }
    it { should_not be_accessible :updated_at }
    it { should_not be_accessible :deleted_at }
  end

  describe "admin attr_accesible" do
    it { should be_admin_accessible :name }
    it { should be_admin_accessible :description }
    it { should be_admin_accessible :public }
    it { should be_admin_accessible :game_system_id }
    it { should be_admin_accessible :owner_id }
    it { should be_admin_accessible :latest_session_at }

    it { should be_admin_accessible :created_at }
    it { should be_admin_accessible :updated_at }
    it { should be_admin_accessible :deleted_at }

    it { should_not be_admin_accessible :id }
  end



  describe "ability" do
    subject { ability }
    let(:ability) { Ability.new(user) }
    let(:user) { FactoryGirl.create :user }
    named_let(:world) { FactoryGirl.create :world }
    named_let(:new_world) { World.new }

    context "When access all guest user" do
      let(:user) { FactoryGirl.build :user }
      it { should be_able_to(:read, world)}
      it { should_not be_able_to(:create, new_world)}
      it { should_not be_able_to(:update, world)}
      it { should_not be_able_to(:destroy, world)}
    end

    context "When user own world" do
      named_let(:world) { FactoryGirl.create :world, :owner => user }
      it { should be_able_to(:manage, world) }
    end

    context "When access other user own world" do
      named_let(:world) { FactoryGirl.create :world }
      it { should be_able_to(:read, world) }
      it { should_not be_able_to(:manage, world) }
      it { should_not be_able_to(:update, world) }
      it { should_not be_able_to(:destroy, world) }
    end

    context "When access logged in user" do
      it { should be_able_to(:create, new_world) }
      it { should be_able_to(:read, world) }
      it { should_not be_able_to(:manage, world)}
      it { should_not be_able_to(:update, world)}
      it { should_not be_able_to(:destroy, world)}
    end
  end

end
