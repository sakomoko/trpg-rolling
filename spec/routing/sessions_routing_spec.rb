require "spec_helper"

describe SessionsController do
  describe "routing" do

    it "routes to #index" do
      get("/worlds/1/sessions").should route_to("sessions#index", :world_id => "1")
    end

    it "routes to #finished" do
      get("/worlds/1/sessions/finished").should route_to("sessions#finished", :world_id => "1")
    end

    it "routes to #new" do
      get("/worlds/1/sessions/new").should route_to("sessions#new", :world_id => "1")
    end

    it "routes to #show" do
      get("/worlds/1/sessions/1").should route_to("sessions#show", :id => "1", :world_id => "1")
    end

    it "routes to #edit" do
      get("/worlds/1/sessions/1/edit").should route_to("sessions#edit", :id => "1", :world_id => "1")
    end

    it "routes to #create" do
      post("/worlds/1/sessions").should route_to("sessions#create", :world_id => "1")
    end

    it "routes to #update" do
      put("/worlds/1/sessions/1").should route_to("sessions#update", :id => "1", :world_id => "1")
    end

    it "routes to #destroy" do
      delete("/worlds/1/sessions/1").should route_to("sessions#destroy", :id => "1", :world_id => "1")
    end

  end
end
