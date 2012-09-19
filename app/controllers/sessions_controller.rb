class SessionsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update]
  load_and_authorize_resource :world
  load_and_authorize_resource :session, :through => :world
  skip_authorize_resource :only => [:new, :create]

  # GET /sessions
  # GET /sessions.xml
  def index
    @sessions = @world.sessions
  end

  # GET /worlds/1/sessions/finished
  # GET /worlds/1/sessions/finished.json
  def finished
    @sessions = @world.sessions.finished
  end

  # GET /sessions/1
  # GET /sessions/1.xml
  def show
    @comment = Comment.new
    @applicant = @session.applicants.new
    @session.reload
  end

  # GET /sessions/new
  # GET /sessions/new.xml
  def new
    @session.world = @world
    authorize! :new, @session
  end

  # GET /sessions/1/edit
  def edit
  end

  # POST /sessions
  # POST /sessions.xml
  def create
    @session.world = @world
    @session.game_master = current_user
    authorize! :create, @session
    @session.save
    respond_with @world, @session
  end

  # PUT /sessions/1
  # PUT /sessions/1.xml
  def update
    @session.update_attributes(params[:session])
    respond_with @world, @session
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.xml
  def destroy
    @session.destroy
    respond_with @world, @session
  end

end
