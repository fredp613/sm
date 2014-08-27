
module Admin
class Admin::TwitterpostersController < ApplicationController

  http_basic_authenticate_with name: Rails.application.secrets.admin_name, password: Rails.application.secrets.admin_password
  before_action :set_twitterposter, only: [:show, :edit, :update, :destroy]

  # GET /twitterposters
  # GET /twitterposters.json
  def index
    @twitterposters = Twitterposter.all
  end

  # GET /twitterposters/1
  # GET /twitterposters/1.json
  def show
  end

  # GET /twitterposters/new
  def new
    @twitterposter = Twitterposter.new
  end

  # GET /twitterposters/1/edit
  def edit
  end

  # POST /twitterposters
  # POST /twitterposters.json
  def create
    @twitterposter = Twitterposter.new(twitterposter_params)

    respond_to do |format|
      if @twitterposter.save
        format.html { redirect_to [:admin, @twitterposter], notice: 'Twitterposter was successfully created.' }
        format.json { render :show, status: :created, location: @twitterposter }
      else
        format.html { render :new }
        format.json { render json: @twitterposter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /twitterposters/1
  # PATCH/PUT /twitterposters/1.json
  def update
    respond_to do |format|
      if @twitterposter.update(twitterposter_params)
        format.html { redirect_to [:admin, @twitterposter], notice: 'Twitterposter was successfully updated.' }
        format.json { render :show, status: :ok, location: @twitterposter }
      else
        format.html { render :edit }
        format.json { render json: @twitterposter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /twitterposters/1
  # DELETE /twitterposters/1.json
  def destroy
    @twitterposter.destroy
    respond_to do |format|
      format.html { redirect_to [:admin, twitterposters_url], notice: 'Twitterposter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_twitterposter
      @twitterposter = Twitterposter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def twitterposter_params
      params.require(:twitterposter).permit(:user_id, :screen_name, :artist_id, :profile_image, :remote_profile_image_url)
    end
end
end