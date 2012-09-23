require 'spec_helper'

describe CharactersController do

  let(:world) { FactoryGirl.create :world, :game_system => game_system }
  let(:game_system) { FactoryGirl.create :game_system, :system_key => "SwordWorldRpg2"}
  let(:user) { FactoryGirl.create :user }
  let(:character) { FactoryGirl.create :sword_world_rpg2, :world => world, user: user }
  let(:other_character) { FactoryGirl.create :sword_world_rpg2, :world => world }
  let(:other_world_character) { FactoryGirl.create :character}

  describe "GET index" do
    subject { assigns :characters }
    before do
      character
      other_character
      get :index, world_id: world.to_param
    end
    it { should eq [character, other_character] }
    it { assigns(:world).should eq character.world }
    it { assigns(:system_key).should eq game_system.system_key.underscore }
  end

  describe "GET show" do
    subject { assigns :character }
    before do
      get :show, id: character.to_param,  world_id: world.to_param
    end
    it { should eq character }
    it { assigns(:world).should eq character.world }
    it { assigns(:system_key).should eq game_system.system_key.underscore }
    it { response.should render_template("show") }
  end

  describe "GET new" do
    subject { assigns :character }
    before do
      sign_in user
      world.join user
      get :new, world_id: world.to_param
    end
    it { should be_new_record }
    it { assigns(:world).should eq world }
    it { assigns(:system_key).should eq game_system.system_key.underscore }
  end

  describe "GET edit" do
    subject { assigns :character }
    before do
      sign_in user
      get :edit, id: character.to_param,  world_id: world.to_param
    end
    it { should_not be_new_record }
    it { should eq character }
    it { assigns(:world).should eq character.world }
    it { assigns(:system_key).should eq game_system.system_key.underscore }
  end

  describe "POST create" do
    subject { assigns :character }
    before do
      sign_in user
      post :create, world_id: world.to_param, sword_world_rpg2: FactoryGirl.attributes_for(:sword_world_rpg2, world: world)
    end
    it { should_not be_new_record }
    it { should be_a(SwordWorldRpg2) }
    it { should be_persisted }
    it { assigns(:world).should eq world }
    it { assigns(:system_key).should eq game_system.system_key.underscore }
    it { response.should redirect_to(world_character_path(world, Character.last)) }
  end

  describe "PUT update" do
    subject { assigns :character }
    before do
      sign_in user
      put :update, id: character.to_param, world_id: world.to_param, sword_world_rpg2: FactoryGirl.attributes_for(:sword_world_rpg2, world: world)
    end
    it { should_not be_new_record }
    it { should be_a(SwordWorldRpg2) }
    it { should be_persisted }
    it { should eq character }
    it { assigns(:world).should eq world }
    it { assigns(:system_key).should eq game_system.system_key.underscore }
    it { response.should redirect_to(world_character_path(world, character)) }
  end

end
