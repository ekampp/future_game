class CharactersController < InheritedResources::Base
  before_filter :require_login
  actions :all, :except => [ :index ]
  load_and_authorize_resource

  def destroy
    destroy! do |format|
      format.html { redirect_to my_account_path }
    end
  end

protected

  #
  # Begins the association chain with the current user
  #
  def begin_of_association_chain
    current_user
  end

  # def create
  #   @character = current_user.characters.new
  #   @character.assign_attributes params[:character], as: current_user.role.to_sym
  #   CharacterMailer.created(@character).deliver if @character.save
  #   respond_with @character
  # end

  # def show
  #   @character = current_user.characters.find(params[:id])
  #   respond_with @chatacter
  # end

  # def edit
  #   @character = current_user.characters.find(params[:id])
  #   respond_with @chatacter
  # end

  # def update
  #   @character = current_user.characters.find(params[:id])
  #   @character.assign_attributes(params[:character], as: current_user.role.to_sym)
  #   CharacterMailer.updated(@character).deliver if @character.changed? and @character.save
  #   respond_with @chatacter, location: character_path(@character)
  # end

  # def destroy
  #   @character = current_user.characters.find(params[:id])
  #   CharacterMailer.destroyed(@character) if @character.destroy
  #   respond_with @chatacter, location: my_account_path
  # end
end
