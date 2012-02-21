class SessionsController < ApplicationController
  # GET /sessions
  # GET /sessions.xml
  def index
    @sessions = Session.where(:world_id => params[:world_id])
    respond_with(@sessions)
  end

  # GET /sessions/1
  # GET /sessions/1.xml
  def show
    @session = Session.find(params[:id])
    respond_with(@session)
  end

  # GET /sessions/new
  # GET /sessions/new.xml
  def new
    @session = Session.new
    @session.world = World.find(params[:world_id])
    respond_with(@session.world, @session)
  end

  # GET /sessions/1/edit
  def edit
    @session = Session.find(params[:id])
  end

  # POST /sessions
  # POST /sessions.xml
  def create
    @session = Session.new(params[:session])
    @session.world = World.find(params[:world_id])
    @session.game_master = current_user
    flash[:notice] = 'Session was successfully created.' if @session.save
    respond_with(@session.world, @session)
  end

  # PUT /sessions/1
  # PUT /sessions/1.xml
  def update
    @session = Session.find(params[:id])
    flash[:notice] = 'Session was successfully updated.' if @session.update_attributes(params[:session])
    respond_with(@session.world, @session)
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.xml
  def destroy
    @session = Session.find(params[:id])
    @session.destroy
    respond_with(@session.world, @session)
  end
end
