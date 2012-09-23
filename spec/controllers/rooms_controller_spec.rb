require 'spec_helper'

describe RoomsController do

  let(:user) { FactoryGirl.create :user}
  named_let(:room) { FactoryGirl.create :room, :user => user }
  let(:valid_attributes) { FactoryGirl.attributes_for(:room) }
  let(:world) { FactoryGirl.create :world, :owner => user}
  let(:session) { FactoryGirl.create :session }

  describe "GET index" do
    subject { assigns(:rooms) }
    named_let!(:room) { FactoryGirl.create :room, roomable: session }

    context "When user access to session rooms" do
      before do
        get :index, session_id: session.to_param
      end
      it { should eq [room] }
    end

    context "When user access to world rooms" do
      named_let!(:room) { FactoryGirl.create :room, roomable: world }
      before do
        get :index, world_id: world.to_param
      end
      it { should eq [room] }
    end

    context "When user access to all rooms" do
      before do
        get :index
      end
      it { should eq [room] }
    end
  end

  describe "GET show" do
    it "assigns the requested room as @room" do
      get :show, {:id => room.to_param}
      assigns(:room).should eq(room)
    end
  end

  describe "GET new" do
    before do
      let_sign_in?
      get :new, { :world_id => world.to_param }
    end
    context "When user logged in" do
      let(:let_sign_in?) { sign_in user }
      it { assigns(:room).should be_a_new(Room) }
    end

    context "When user not logged in" do
      let(:let_sign_in?) { sign_out user }
      it { response.should redirect_to(new_user_session_path)}
    end
  end

  describe "GET edit" do
    before do
      sign_in user
      get :edit, {:id => room.to_param}
    end
    it { assigns(:room).should eq room }
  end

  describe "POST create" do

    let(:room) { FactoryGirl.attributes_for :room }

    context "When user logged in" do
      before do
        sign_in user
      end

      describe "with valid params" do
        it "creates a new Room" do
          expect {
            post :create, {:room => room, :world_id => world.to_param }
          }.to change(Room, :count).by(1)
        end

        it "assigns a newly created room as @room" do
          post :create, {:room => room, :world_id => world.to_param }
          assigns(:room).should be_a(Room)
          assigns(:room).should be_persisted
        end

        it "redirects to the created room" do
          post :create, {:room => room, :world_id => world.to_param }
          response.should redirect_to(world)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved room as @room" do
          # Trigger the behavior that occurs when invalid params are submitted
          Room.any_instance.stub(:create).and_return(false)
          post :create, {:room => {}, :world_id => world.to_param }
          assigns(:room).should be_a_new(Room)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Room.any_instance.stub(:create).and_return(false)
          post :create, {:room => {}, :world_id => world.to_param }
          response.should render_template("new")
        end
      end
    end

    context "When user not logged in" do
      before do
        post :create, {:room => room}
      end
      it { response.should redirect_to(new_user_session_path) }
    end
  end

  describe "PUT update" do
    let(:world) { FactoryGirl.create :world }
    named_let(:room) { FactoryGirl.create :room, user: user, roomable: world }
    describe "with valid params" do
      before do
        sign_in user
        put :update, {:id => room.to_param, :room => valid_attributes, world_id: room.roomable.to_param }
      end
      it "updates the requested room" do
        # Assuming there are no other rooms in the database, this
        # specifies that the Room created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Room.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => room.to_param, :room => {'these' => 'params'}}
      end

      it "assigns the requested room as @room" do
        assigns(:room).should eq(room)
      end

      it "redirects to the parent" do
        response.should redirect_to room.roomable
      end
    end

    describe "with invalid params" do
      before do
        sign_in user
        put :update, {:id => room.to_param, :room => {}, world_id: room.roomable.to_param }
      end
      it "assigns the room as @room" do
        # Trigger the behavior that occurs when invalid params are submitted
        Room.any_instance.stub(:save).and_return(false)
        assigns(:room).should eq(room)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Room.any_instance.stub(:save).and_return(false)
        response.should redirect_to room.roomable
      end
    end
  end

  describe "DELETE destroy" do
    named_let(:room) { FactoryGirl.create :room, :user => user, :roomable => world }
    before do
      sign_in user
      delete :destroy, {:id => room.to_param, world_id: world.to_param }
    end
    it "destroys the requested room" do
      assigns(:room).should be_destroyed
    end

    it "redirects to the rooms list" do
      response.should redirect_to world
    end
  end

  describe "PUT close" do
    named_let(:room) { FactoryGirl.create :room, :user => user, :roomable => world }
    before do
      sign_in user
      put :close, { :id => room.to_param, :world_id => world.to_param }
    end
    it { assigns(:room).should be_closed }
    it { response.should redirect_to world }
  end

end
