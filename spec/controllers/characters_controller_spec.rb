require 'spec_helper'

describe CharactersController do

  let(:world) { FactoryGirl.create :world, :game_system => game_system }
  let(:game_system) { FactoryGirl.create :game_system, :system_key => "SwordWorldRpg2"}
  let(:character) { FactoryGirl.create :sword_world_rpg2, :world => world }
  let(:other_character) { FactoryGirl.create :sword_world_rpg2, :world => world }
  let(:other_world_character) { FactoryGirl.create :character}

  describe "GET index" do
    subject { assigns :characters }
    before do
      get :index, world_id: world.to_param
    end
    its(:to_a) { should eq [character, other_character] }
    it { assigns(:world).should eq character.world }
    it { assigns(:system_key).should eq game_system.system_key.underscore }
  end

  describe "GET new" do
    subject { assigns :character }
    before do
      get :new, world_id: world.to_param
    end
    it { should be_new_record }
    it { assigns(:world).should eq world }
    it { assigns(:system_key).should eq game_system.system_key.underscore }
  end

  describe "GET edit" do
    subject { assigns :character }
    before do
      get :edit, id: character.to_param,  world_id: world.to_param
    end
    it { should_not be_new_record }
    it { should eq character }
    it { assigns(:world).should eq character.world }
    it { assigns(:system_key).should eq game_system.system_key.underscore }
  end
end
