require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe SessionsController do

  let(:user) { Factory :user }
  let(:session) { Factory :session }
  let(:other_world_session) { Factory :session }
  let(:valid_attributes) { Factory.build(:session, :world => session.world).attributes.symbolize_keys}

  subject { assigns(:session) }

  describe "GET index" do
    subject { assigns(:sessions) }
    before do
      Factory :session
      get :index, :world_id => session.world.to_param
    end
    it { should be_stored_in :sessions }
    it "assigns all sessions as @sessions" do
      assigns(:sessions).to_a.should eq([session])
    end
  end

  describe "GET show" do
    before do
      get :show, {:id => session.to_param, :world_id => session.world.to_param}
    end
    it { should eq session }
  end

  describe "GET new" do
    before do
      get :new, :world_id => session.world.to_param
    end
    it { should be_a_new Session }
  end

  describe "GET edit" do
    before do
      get :edit, {:id => session.to_param, :world_id => session.world.to_param }
    end
    it { should eq session }
  end

  describe "POST create" do
    before do
      sign_in user
    end
    context "with valid params" do
      before do
        post :create, {:session => valid_attributes, :world_id => session.world.to_param }
      end
      it { should_not be_new_record }
      it { should be_a Session }
      it { should be_persisted }
      its(:game_master) { should eq user }
      it { response.status.should eq 302 }
    end

    context "with invalid params" do
      before do
        Session.any_instance.stub(:save).and_return(false)
        post :create, {:session => {}, :world_id => session.world.to_param }
      end
      it { should be_a_new Session }
      it { response.should render_template("new") }
    end
  end

  describe "PUT update" do
    before do
      sign_in user
    end

    context "with valid params" do
      before do
        put :update, {:id => session.to_param, :session => valid_attributes, :world_id => session.world.to_param }
      end
      its(:id) { should eq session.id }

      it "redirects to the session" do
        response.should redirect_to(world_session_path(session.world))
      end
    end

    context "with invalid params" do
      before do
        Session.any_instance.stub(:save).and_return(false)
        put :update, {:id => session.to_param, :session => {}, :world_id => session.world.to_param }
      end
      its(:id) { should eq session.id }

      it "re-renders the 'edit' template" do
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before do
      delete :destroy, {:id => session.to_param, :world_id => session.world.to_param}
    end
    it { should be_destroyed }

    it "redirects to the sessions list" do
      response.should redirect_to(world_sessions_url(session.world))
    end
  end

end
