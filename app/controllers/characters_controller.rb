class CharactersController < ApplicationController

  def index
    @world = World.find params[:world_id]
    @system_key = @world.game_system.system_key.underscore
    @characters = @world.characters
    respond_with @world, @characters
  end

  def new
    @world = World.find params[:world_id]
    model_name  = @world.game_system.system_key
    @system_key = model_name.underscore
    model = self.class.const_get model_name
    @character = model.new
    respond_with(@world, @character)
  end

  def edit
    @world = World.find params[:world_id]
    @character = Character.find params[:id]
    @system_key = @world.game_system.system_key.underscore
    respond_with @world, @character
  end
end
