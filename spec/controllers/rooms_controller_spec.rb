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

describe RoomsController do

  let(:user) { Factory :user}
  named_let(:room) { Factory :room, :user => user }
  let(:valid_attributes) { Factory.attributes_for(:room) }
  let(:world) { Factory :world, :owner => user}

  describe "GET index" do
    it "assigns all rooms as @rooms" do
      get :index
      assigns(:rooms).should eq([room])
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

    let(:room) { Factory.attributes_for :room }

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
          response.should redirect_to(Room.last)
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
    describe "with valid params" do
      before do
        sign_in user
        put :update, {:id => room.to_param, :room => valid_attributes}
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

      it "redirects to the room" do
        response.should redirect_to(room)
      end
    end

    describe "with invalid params" do
      before do
        sign_in user
        put :update, {:id => room.to_param, :room => {}}
      end
      it "assigns the room as @room" do
        # Trigger the behavior that occurs when invalid params are submitted
        Room.any_instance.stub(:save).and_return(false)
        assigns(:room).should eq(room)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Room.any_instance.stub(:save).and_return(false)
        response.should redirect_to(room_path(room))
      end
    end
  end

  describe "DELETE destroy" do
    before do
      sign_in user
      delete :destroy, {:id => room.to_param}
    end
    it "destroys the requested room" do
      assigns(:room).should be_destroyed
    end

    it "redirects to the rooms list" do
      response.should redirect_to(rooms_url)
    end
  end

  describe "PUT close" do
    named_let(:room) { Factory :room, :user => user, :roomable => world }
    before do
      sign_in user
      put :close, { :id => room.to_param, :world_id => world.to_param }
    end
    it { assigns(:room).should be_closed }
    it { response.should redirect_to(room_path(room)) }
  end

end
