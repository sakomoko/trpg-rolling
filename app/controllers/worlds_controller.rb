class WorldsController < ApplicationController

  respond_to :html, :json

  # GET /worlds
  # GET /worlds.json
  def index
    @worlds = World.all
    respond_with @worlds
  end

  # GET /worlds/1
  # GET /worlds/1.json
  def show
    @world = World.find(params[:id])
    @sessions = @world.sessions.playing
    @rooms = @world.rooms.static.opened
    respond_with @world
  end

  # GET /worlds/new
  # GET /worlds/new.json
  def new
    @world = World.new
    respond_with @world
  end

  # GET /worlds/1/edit
  def edit
    @world = World.find(params[:id])
  end

  # POST /worlds
  # POST /worlds.json
  def create
    @world = World.create(params[:world]) do |m|
      m.owner = current_user
    end

    respond_with @world
  end

  # PUT /worlds/1
  # PUT /worlds/1.json
  def update
    @world = World.find(params[:id])
    @world.update_attributes(params[:world])
    respond_with @world
  end

  # DELETE /worlds/1
  # DELETE /worlds/1.json
  def destroy
    @world = World.find(params[:id])
    @world.destroy
    respond_with @world
  end
end
