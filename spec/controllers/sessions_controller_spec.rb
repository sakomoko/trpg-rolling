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

  let(:user) { FactoryGirl.create :user }
  let(:session) { FactoryGirl.create :session, :game_master => user }
  let(:other_world_session) { FactoryGirl.create :session }
  let(:valid_attributes) { FactoryGirl.build(:session, :world => session.world).attributes.symbolize_keys}

  subject { assigns(:session) }

  describe "GET index" do
    subject { assigns(:sessions) }
    before do
      get :index, :world_id => session.world.to_param
    end
    its(:to_a) { should eq [session] }
    it { assigns(:world).should eq session.world }
  end

  describe "GET finished" do
    let(:session) { FactoryGirl.create :session, finished: true }
    subject { assigns(:sessions) }
    before do
      get :finished, :world_id => session.world.to_param
    end
    its(:to_a) { should eq [session] }
    it { assigns(:world).should eq session.world }
  end

  describe "GET show" do
    before do
      get :show, {:id => session.to_param, :world_id => session.world.to_param}
    end
    it { should eq session }
    it { assigns(:comment).should be_a_new Comment }
  end

  describe "GET new" do
    context "When a user logged in" do
      before do
        sign_in user
        get :new, :world_id => session.world.to_param
      end
      it { should be_a_new Session }
      its(:world) { should eq session.world }
    end

    context "When a user not logged in" do
      before do
        get :new, :world_id => session.world.to_param
      end
      it { response.should redirect_to(new_user_session_path)}
    end
  end

  describe "GET edit" do
    context "When a user logged in" do
      before do
        sign_in user
        get :edit, {:id => session.to_param, :world_id => session.world.to_param }
      end
      it { should eq session }
    end

    context "When a user not logged in" do
      before do
        get :edit, {:id => session.to_param, :world_id => session.world.to_param }
      end
      it { response.should redirect_to(new_user_session_path) }
    end
  end

  describe "POST create" do
    context "When a user logged in" do
      before do
        sign_in user
        session.world.join user
      end
      context "with valid params" do
        before do
          post :create, {:session => valid_attributes, :world_id => session.world.to_param }
        end
        it { should_not be_new_record }
        it { should be_a Session }
        it { should be_persisted }
        its(:game_master) { should eq user }
        it { controller.should respond_with(:redirect) }
      end

      context "with invalid params" do
        before do
          session
          Session.any_instance.stub(:save).and_return(false)
          post :create, {:session => {}, :world_id => session.world.to_param }
        end
        it { should be_a_new Session }
        it { controller.should respond_with :redirect }
      end
    end

    context "When a user not logged in" do
      before do
        post :create, {:session => valid_attributes, :world_id => session.world.to_param }
      end
      it { response.should redirect_to(new_user_session_path) }
    end
  end

  describe "PUT update" do
    context "When a user logged in" do
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
          session
          Session.any_instance.stub(:save).and_return(false)
          put :update, {:id => session.to_param, :session => {}, :world_id => session.world.to_param }
        end
        its(:id) { should eq session.id }

        it "re-renders the 'edit' template" do
          controller.should respond_with :redirect
        end
      end
    end

    context "When a user not logged in" do
      before do
        put :update, {:id => session.to_param, :session => valid_attributes, :world_id => session.world.to_param }
      end
      it { response.should redirect_to(new_user_session_path) }
    end
  end

  describe "DELETE destroy" do
    before do
      sign_in user
      delete :destroy, {:id => session.to_param, :world_id => session.world.to_param}
    end
    it { should be_destroyed }

    it "redirects to the sessions list" do
      response.should redirect_to(world_sessions_url(session.world))
    end
  end

end
