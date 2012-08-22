require "spec_helper"

describe CharactersController do

  describe "routing" do

    describe "worlds/character routing" do
      it "routes to #index" do
        get("/worlds/1/characters").should route_to("characters#index", :world_id => "1")
      end

      it "routes to #new" do
        get("/worlds/1/characters/new").should route_to("characters#new", :world_id => "1")
      end

      it "routes to #show" do
        get("/worlds/1/characters/1").should route_to("characters#show", :id => "1", :world_id => "1")
      end

      it "routes to #edit" do
        get("/worlds/1/characters/1/edit").should route_to("characters#edit", :id => "1", :world_id => "1")
      end

      it "routes to #create" do
        post("/worlds/1/characters").should route_to("characters#create", :world_id => "1")
      end

      it "routes to #update" do
        put("/worlds/1/characters/1").should route_to("characters#update", :id => "1", :world_id => "1")
      end

      it "routes to #destroy" do
        delete("/worlds/1/characters/1").should route_to("characters#destroy", :id => "1", :world_id => "1")
      end
    end

    describe "users/character routing" do
      it "routes to #index" do
        get("/users/1/characters").should route_to("characters#index", :user_id => "1")
      end

      it "routes to #show" do
        get("/users/1/characters/1").should route_to("characters#show", :id => "1", :user_id => "1")
      end
    end
  end
end
