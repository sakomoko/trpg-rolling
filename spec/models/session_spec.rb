require 'spec_helper'
require "cancan/matchers"

describe Session do

  describe "associations" do
    it { should belong_to :world }
    it { should belong_to(:game_master).of_type(User) }
    it { should have_many(:rooms).as_inverse_of(:roomable) }
    it { should embed_many(:comments) }
    it { should embed_many(:applicants).of_type(Session::Applicant) }
  end

  describe "fields" do
    it { should have_field(:title).of_type(String) }
    it { should have_field(:description).of_type(String) }
    it { should have_field(:guidelines).of_type(String) }

    it { should have_field(:public).of_type(Boolean).with_default_value_of(true) }
    it { should have_field(:finished).of_type(Boolean).with_default_value_of(false) }
    it { should have_field(:fix_applicant).of_type(Boolean).with_default_value_of(false) }

    it { should have_field(:started_at).of_type(DateTime) }
    it { should have_field(:finished_at).of_type(DateTime) }
    it { should have_field(:closed_at).of_type(DateTime) }
    it { should have_field(:deadline).of_type(DateTime) }
  end

  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :game_master_id }
    it { should validate_presence_of :world_id }

    it { should validate_presence_of :started_at }
    it { should validate_presence_of :finished_at }
  end

  describe "attr_accesible" do
    it { should allow_mass_assignment_of :title }
    it { should allow_mass_assignment_of :description }
    it { should allow_mass_assignment_of :started_at }
    it { should allow_mass_assignment_of :finished_at }
    it { should allow_mass_assignment_of :deadline }
    it { should allow_mass_assignment_of :guidelines }
    it { should allow_mass_assignment_of :public }
    it { should allow_mass_assignment_of :fix_applicant }

    it { should_not allow_mass_assignment_of :id }
    it { should_not allow_mass_assignment_of :world_id }
    it { should_not allow_mass_assignment_of :game_master_id }

    it { should_not allow_mass_assignment_of :finished }
    it { should_not allow_mass_assignment_of :closed_at }

    it { should_not allow_mass_assignment_of :created_at }
    it { should_not allow_mass_assignment_of :updated_at }
  end

  describe "admin attr_accesible" do
    it { should allow_mass_assignment_of(:title).as(:admin) }
    it { should allow_mass_assignment_of(:description).as(:admin) }
    it { should allow_mass_assignment_of(:started_at).as(:admin) }
    it { should allow_mass_assignment_of(:finished_at).as(:admin) }
    it { should allow_mass_assignment_of(:guidelines).as(:admin) }
    it { should allow_mass_assignment_of(:public).as(:admin) }

    it { should allow_mass_assignment_of(:world_id).as(:admin) }
    it { should allow_mass_assignment_of(:game_master_id).as(:admin) }

    it { should allow_mass_assignment_of(:finished).as(:admin) }
    it { should allow_mass_assignment_of(:closed_at).as(:admin) }
    it { should allow_mass_assignment_of(:created_at).as(:admin) }
    it { should allow_mass_assignment_of(:updated_at).as(:admin) }
    it { should allow_mass_assignment_of(:deadline).as(:admin) }
    it { should allow_mass_assignment_of(:fix_applicant).as(:admin) }
  end


  describe "ability" do
    subject { ability }
    let(:ability) { Ability.new(user) }
    let(:user) { FactoryGirl.create :user }
    let(:world) { FactoryGirl.create :world }
    named_let(:session) { FactoryGirl.create :session }
    named_let(:new_session) { Session.new }

    context "When access all guest user" do
      let(:user) { FactoryGirl.build :user }
      it { should be_able_to(:read, session)}
      it { should_not be_able_to(:create, new_session)}
      it { should_not be_able_to(:update, session)}
      it { should_not be_able_to(:destroy, session)}
    end

    context "When user own session" do
      named_let(:session) { FactoryGirl.create :session, :game_master => user }
      it { should be_able_to(:manage, session) }
    end

    context "When access other user's session" do
      named_let(:session) { FactoryGirl.create :session }
      it { should be_able_to(:read, session) }
      it { should_not be_able_to(:manage, session) }
      it { should_not be_able_to(:update, session) }
      it { should_not be_able_to(:destroy, session) }
    end

    context "When access logged in user" do
      it { should be_able_to(:read, session) }
      it { should_not be_able_to(:manage, session)}
      it { should_not be_able_to(:update, session)}
      it { should_not be_able_to(:destroy, session)}

      context "When user alredy joined" do
        before do
          world.join user
          new_session.world = world
        end
        it { should be_able_to(:create, new_session) }
      end

      context "When user not joined" do
        before do
          new_session.world = world
        end
        it { should_not be_able_to(:create, new_session) }
      end
    end

    context "When access Session World Owner" do
      let(:world) { FactoryGirl.create :world, :owner => user }
      named_let(:session) { FactoryGirl.create :session, :world => world}
      it { should be_able_to(:manage, session)}
    end
  end

end
