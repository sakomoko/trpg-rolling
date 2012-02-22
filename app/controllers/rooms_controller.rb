class RoomsController < ApplicationController

  respond_to :html, :json

  # GET /rooms
  # GET /rooms.json
  def index
    if params[:session_id]
      @session = Session.find(params[:session_id])
      @rooms = @session.rooms.desc :created_at
    else
      @rooms = Room.all.desc :created_at
    end
    respond_with @rooms
  end

  # GET /rooms/closed
  # GET /rooms/closed.json
  def closed
    @rooms = Room.where(closed: true).desc :created_at
    respond_with @rooms, template: "rooms/index"
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @room = Room.find(params[:id])
    respond_with @room
  end

  # GET /rooms/new
  # GET /rooms/new.json
  def new
    @room = Room.new
    @session = Session.find(params[:session_id]) if params[:session_id]
    respond_with @room
  end

  # GET /rooms/1/edit
  def edit
    @room = Room.find(params[:id])
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @session = Session.find(params[:session_id]) if params[:session_id]
    @room = Room.create(params[:room]) do |r|
      r.user = current_user
      if params[:session_id]
        r.roomable = @session if @session
      end
    end
    respond_with @room
  end

  # PUT /rooms/1
  # PUT /rooms/1.json
  def update
    @room = Room.find(params[:id])

    respond_to do |format|
      if @room.update_attributes(params[:room])
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    respond_with @room
  end
end
