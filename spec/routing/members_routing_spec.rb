require "spec_helper"

describe MembersController do
  describe "routing" do

    it "routes to #index" do
      get("/worlds/1/members").should route_to("members#index", :world_id => "1")
    end

    it "routes to #awaiting" do
      get("/worlds/1/members/awaiting").should route_to("members#awaiting", :world_id => "1")
    end

    it "routes to #new" do
      get("/worlds/1/members/new").should route_to("members#new", :world_id => "1")
    end

    it "routes to #show" do
      get("/worlds/1/members/1").should route_to("members#show", :id => "1", :world_id => "1")
    end

    it "routes to #edit" do
      get("/worlds/1/members/1/edit").should route_to("members#edit", :id => "1", :world_id => "1")
    end

    it "routes to #create" do
      post("/worlds/1/members").should route_to("members#create", :world_id => "1")
    end

    it "routes to #update" do
      put("/worlds/1/members/1").should route_to("members#update", :id => "1", :world_id => "1")
    end

    it "routes to #apply" do
      put("/worlds/1/members/1/apply").should route_to("members#apply", :id => "1", :world_id => "1")
    end

    it "routes to #destroy" do
      delete("/worlds/1/members/1").should route_to("members#destroy", :id => "1", :world_id => "1")
    end

  end
end
