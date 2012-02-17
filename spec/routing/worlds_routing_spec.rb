require "spec_helper"

describe WorldsController do
  describe "routing" do

    it "routes to #index" do
      get("/worlds").should route_to("worlds#index")
    end

    it "routes to #new" do
      get("/worlds/new").should route_to("worlds#new")
    end

    it "routes to #show" do
      get("/worlds/1").should route_to("worlds#show", :id => "1")
    end

    it "routes to #edit" do
      get("/worlds/1/edit").should route_to("worlds#edit", :id => "1")
    end

    it "routes to #create" do
      post("/worlds").should route_to("worlds#create")
    end

    it "routes to #update" do
      put("/worlds/1").should route_to("worlds#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/worlds/1").should route_to("worlds#destroy", :id => "1")
    end

  end
end
