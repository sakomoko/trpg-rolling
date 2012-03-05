# -*- coding: utf-8 -*-
require 'spec_helper'
require "cancan/matchers"

describe Room do
  describe '#find_parent' do
    context 'paramsにsession_idが含まれていたとき' do
      let(:session) { Factory :session }
      subject { Room.find_parent_model({ :session_id => session.id}) }
      it { should be_a Session }
      it { should eq session }
    end

    context 'paramsにworld_idが含まれていたとき' do
      let(:world) { Factory :world }
      subject { Room.find_parent_model({ :world_id => world.id}) }
      it { should be_a World }
      it { should eq world }
    end

    context 'paramsにsession/worldのキーが含まれていないとき' do
      subject { Room.find_parent_model({ }) }
      it { should be_nil }
    end
  end

  describe "ability" do
    subject { ability }

    let(:ability) { Ability.new(user) }
    named_let(:user) { Factory :user }
    named_let(:new_room) { Room.new }
    named_let(:room) { Factory :room }

    context "When create SessionRoom from member" do
      named_let(:new_room) { Factory.build :room, :roomable => Factory(:session) }
      it { should_not be_able_to(:create, new_room)}
      it { should_not be_able_to(:manage, room) }
    end

    context "When create SessionRoom from game_master" do
      named_let(:new_room) { Factory.build :room, :roomable => Factory(:session, :game_master => user) }
      it { should be_able_to(:create, new_room)}
      it { should be_able_to(:manage, new_room) }
    end

    context "When create WorldRoom from member" do
      it { should_not be_able_to(:create, new_room) }
      it { should_not be_able_to(:manage, room) }
    end

    context "When create WorldRoom from World owner" do
      named_let(:new_room) { Factory.build :room, :roomable => Factory(:world, :owner => user)}
      it { should be_able_to(:manage, new_room)}
    end

    context "When editing user own" do
      named_let(:room) { Factory :room, :user => user }
      it { should be_able_to(:update, room) }
      it { should be_able_to(:destroy, room) }
    end

    context "When editing room of others" do
      it { should be_able_to(:read, room)}
      it { should_not be_able_to(:manage, room) }
      it { should_not be_able_to(:create, new_room) }
      it { should_not be_able_to(:update, room) }
      it { should_not be_able_to(:destroy, room) }
    end

    context "When access guest user" do
      let(:user) { Factory.build :user }
      it { should be_able_to(:read, room) }
      it { should_not be_able_to(:manage, room) }
      it { should_not be_able_to(:create, new_room) }
      it { should_not be_able_to(:update, room) }
      it { should_not be_able_to(:destroy, room) }
    end

  end
end
