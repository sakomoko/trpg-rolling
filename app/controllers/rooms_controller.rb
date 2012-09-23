class RoomsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :closed, :show]
  load_resource :world
  load_resource :session
  before_filter :load_world_and_parent
  load_and_authorize_resource :room, :through => [:session, :world], :shallow => true

  respond_to :html, :json

  def index
    if @session
      @rooms = @session.rooms.desc :created_at
    elsif @world
      @rooms = @world.rooms.opened.desc :created_at
    else
      @rooms = @rooms.opened.desc :created_at
    end
  end

  def closed
    @rooms = Room.closed.desc :created_at
    respond_with @rooms, template: "rooms/index"
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @room = Room.create(params[:room]) do |r|
      r.user = current_user
      if @parent
        r.roomable = @parent
      end
    end
    redirect_to_parent
  end

  def update
    @room.update_attributes(params[:room])
    redirect_to_parent
  end

  def close
    @room.closed = true
    @room.save
    redirect_to_parent
  end

  def destroy
    @room.destroy
    redirect_to_parent
  end

  private
  def load_world_and_parent
    @parent = Room.find_parent_model params
    @world = @session.world if @world.nil? && @session
  end

  def redirect_to_parent
    if @session
      respond_with @room, :location => world_session_path(@world, @session)
    else
      respond_with @room, :location => world_path(@world)
    end
  end

end
