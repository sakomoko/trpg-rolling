class CharactersController < ApplicationController

  def index
    @world = World.find params[:world_id]
    @system_key = @world.game_system.system_key.underscore
    @characters = @world.characters
  end
end
