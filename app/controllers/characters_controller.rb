class CharactersController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update]
  load_and_authorize_resource :world
  load_and_authorize_resource :character, :through => :world
  skip_load_and_authorize_resource :only => [:create, :new]

  def index
    @system_key = @world.game_system.system_key.underscore
    @characters = @world.characters
    respond_with @world, @characters
  end

  def show
    @system_key = @world.game_system.system_key.underscore
    respond_with @world, @character
  end

  def new
    @world = World.find params[:world_id]
    model_name  = @world.game_system.system_key
    @system_key = model_name.underscore
    model = self.class.const_get model_name
    @character = model.new do |m|
      m.world = @world
    end
    authorize! :new, @character
    respond_with @world, @character
  end

  def edit
    @system_key = @world.game_system.system_key.underscore
    respond_with @world, @character
  end

  def create
    @world = World.find params[:world_id]
    model_name = @world.game_system.system_key
    @system_key = model_name.underscore
    model = self.class.const_get model_name
    @character = model.new params[@system_key] do |m|
      m.user = current_user
      m.world = @world
      m.game_system = @world.game_system
    end
    authorize! :create, @character
    @character.save!
    respond_with @world, @character
  end

  def update
    @system_key = @world.game_system.system_key.underscore
    @character.update_attributes params[@system_key]
    respond_with @world, @character
  end
end
