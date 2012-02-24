# -*- coding: utf-8 -*-
require 'spec_helper'

describe Room do
  describe '#find_parent', do
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
end
