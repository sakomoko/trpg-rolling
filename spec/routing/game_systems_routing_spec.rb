require "spec_helper"

describe GameSystemsController do
  describe "routing" do

    it "routes to #index" do
      get("/game_systems").should route_to("game_systems#index")
    end

    it "routes to #new" do
      get("/game_systems/new").should route_to("game_systems#new")
    end

    it "routes to #show" do
      get("/game_systems/1").should route_to("game_systems#show", :id => "1")
    end

    it "routes to #edit" do
      get("/game_systems/1/edit").should route_to("game_systems#edit", :id => "1")
    end

    it "routes to #create" do
      post("/game_systems").should route_to("game_systems#create")
    end

    it "routes to #update" do
      put("/game_systems/1").should route_to("game_systems#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/game_systems/1").should route_to("game_systems#destroy", :id => "1")
    end

  end
end
