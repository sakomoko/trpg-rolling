class GameSystemsController < ApplicationController
  load_and_authorize_resource

  # GET /game_systems
  # GET /game_systems.json
  def index
    @game_systems = GameSystem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @game_systems }
    end
  end

  # GET /game_systems/1
  # GET /game_systems/1.json
  def show
    @game_system = GameSystem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game_system }
    end
  end

  # GET /game_systems/new
  # GET /game_systems/new.json
  def new
    @game_system = GameSystem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game_system }
    end
  end

  # GET /game_systems/1/edit
  def edit
    @game_system = GameSystem.find(params[:id])
  end

  # POST /game_systems
  # POST /game_systems.json
  def create
    @game_system = GameSystem.new(params[:game_system])

    respond_to do |format|
      if @game_system.save
        format.html { redirect_to @game_system, notice: 'Game system was successfully created.' }
        format.json { render json: @game_system, status: :created, location: @game_system }
      else
        format.html { render action: "new" }
        format.json { render json: @game_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /game_systems/1
  # PUT /game_systems/1.json
  def update
    @game_system = GameSystem.find(params[:id])

    respond_to do |format|
      if @game_system.update_attributes(params[:game_system])
        format.html { redirect_to @game_system, notice: 'Game system was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @game_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_systems/1
  # DELETE /game_systems/1.json
  def destroy
    @game_system = GameSystem.find(params[:id])
    @game_system.destroy

    respond_to do |format|
      format.html { redirect_to game_systems_url }
      format.json { head :ok }
    end
  end
end
