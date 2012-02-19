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

describe GameSystemsController do

  let(:game_system) { Factory :game_system }
  let(:valid_attributes) { Factory.attributes_for(:game_system) }

  describe "GET index" do
    it "assigns all game_systems as @game_systems" do
      get :index
      assigns(:game_systems).should eq([game_system])
    end
  end

  describe "GET show" do
    it "assigns the requested game_system as @game_system" do
      get :show, {:id => game_system.to_param}
      assigns(:game_system).should eq(game_system)
    end
  end

  describe "GET new" do
    it "assigns a new game_system as @game_system" do
      get :new
      assigns(:game_system).should be_a_new(GameSystem)
    end
  end

  describe "GET edit" do
    it "assigns the requested game_system as @game_system" do
      get :edit, {:id => game_system.to_param}
      assigns(:game_system).should eq(game_system)
    end
  end

  describe "POST create" do

    let(:game_system) { Factory.attributes_for :game_system }

    describe "with valid params" do
      it "creates a new GameSystem" do
        expect {
          post :create, {:game_system => game_system }
        }.to change(GameSystem, :count).by(1)
      end

      it "assigns a newly created game_system as @game_system" do
        post :create, {:game_system => game_system}
        assigns(:game_system).should be_a(GameSystem)
        assigns(:game_system).should be_persisted
      end

      it "redirects to the created game_system" do
        post :create, {:game_system => game_system}
        response.should redirect_to(GameSystem.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved game_system as @game_system" do
        # Trigger the behavior that occurs when invalid params are submitted
        GameSystem.any_instance.stub(:save).and_return(false)
        post :create, {:game_system => {}}
        assigns(:game_system).should be_a_new(GameSystem)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        GameSystem.any_instance.stub(:save).and_return(false)
        post :create, {:game_system => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested game_system" do
        # Assuming there are no other game_systems in the database, this
        # specifies that the GameSystem created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        GameSystem.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => game_system.to_param, :game_system => {'these' => 'params'}}
      end

      it "assigns the requested game_system as @game_system" do
        put :update, {:id => game_system.to_param, :game_system => valid_attributes}
        assigns(:game_system).should eq(game_system)
      end

      it "redirects to the game_system" do
        put :update, {:id => game_system.to_param, :game_system => valid_attributes}
        response.should redirect_to(game_system)
      end
    end

    describe "with invalid params" do
      it "assigns the game_system as @game_system" do
        # Trigger the behavior that occurs when invalid params are submitted
        GameSystem.any_instance.stub(:save).and_return(false)
        put :update, {:id => game_system.to_param, :game_system => {}}
        assigns(:game_system).should eq(game_system)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        GameSystem.any_instance.stub(:save).and_return(false)
        put :update, {:id => game_system.to_param, :game_system => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested game_system" do
      delete :destroy, {:id => game_system.to_param}
      assigns(:game_system).should be_destroyed
    end

    it "redirects to the game_systems list" do
      delete :destroy, {:id => game_system.to_param}
      response.should redirect_to(game_systems_url)
    end
  end

end