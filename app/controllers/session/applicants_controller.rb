class Session::ApplicantsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :session
  load_and_authorize_resource :world

  def new
    @applicant = @session.applicants.new
    @characters = current_user.characters.where(world: @world)
    authorize! :new, @applicant
    respond_with(@applicant, :layout => !request.xhr?)
  end

  def create
    @applicant = @session.applicants.new params[:session_applicant] do |m|
      m.character = current_user.characters.where(world: @world).find(params[:session_applicant][:character_id])
    end
    authorize! :create, @applicant
    @applicant.save!
  end

  def edit
    authorize! :update, @session
    @applicants = @session.applicants
  end

  def select
    authorize! :update, @session
    @applicant = @session.applicants.find(params[:id])
    @applicant.status = :approved
    @session.save!
  end

  def remove
    authorize! :update, @session
    @applicant = @session.applicants.find(params[:id])
    @applicant.status = :entry
    @session.save!
  end

  def fix
    authorize! :update, @session
    @session.fix_applicant = true
    @session.save!
    respond_with @session, :location => world_session_path(@world, @session)
  end

end
