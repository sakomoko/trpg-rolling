class MembersController < ApplicationController
  before_filter :authenticate_user!, :only => [:awaiting, :new, :create, :apply, :destroy]
  load_and_authorize_resource :world

  def index
    authorize! :index, Member
    @members = @world.members.approved
  end

  def awaiting
    authorize! :manage, Member
    @members = @world.members.awaiting
  end

  def new
    @member = Member.new
    authorize! :new, @member
  end

  def create
    authorize! :create, Member
    @member = @world.register(current_user)
    respond_with @member, location: world_path(@world)
  end

  def apply
    @member = @world.members.find params[:id]
    authorize! :update, @member
    @member = @world.join current_user
    respond_with @member, location: awaiting_world_members_path(@world)
  end

  def destroy
    @member = @world.members.find params[:id]
    authorize! :destroy, @member
    @member.destroy
  end

end
