module Admin

class InstagrampostersController < ApplicationController
  
  # http_basic_authenticate_with name: Rails.application.secrets.admin_name, password: Rails.application.secrets.admin_password
  before_action :set_instagramposter, only: [:show, :edit, :update, :destroy]
  before_filter :admin_authentication

  # GET /instagramposters
  # GET /instagramposters.json
  def index
    @instagramposters = Instagramposter.all
  end

  # GET /instagramposters/1
  # GET /instagramposters/1.json
  def show
  end

  # GET /instagramposters/new
  def new
    @instagramposter = Instagramposter.new
  end

  # GET /instagramposters/1/edit
  def edit
  end

  # POST /instagramposters
  # POST /instagramposters.json
  def create
    @instagramposter = Instagramposter.new(instagramposter_params)

    respond_to do |format|
      if @instagramposter.save
        format.html { redirect_to [:admin, @instagramposter], notice: 'Instagramposter was successfully created.' }
        format.json { render :show, status: :created, location: @instagramposter }
      else
        format.html { render :new }
        format.json { render json: @instagramposter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instagramposters/1
  # PATCH/PUT /instagramposters/1.json
  def update
    respond_to do |format|
      if @instagramposter.update(instagramposter_params)
        format.html { redirect_to [:admin, @instagramposter], notice: 'Instagramposter was successfully updated.' }
        format.json { render :show, status: :ok, location: @instagramposter }
      else
        format.html { render :edit }
        format.json { render json: @instagramposter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instagramposters/1
  # DELETE /instagramposters/1.json
  def destroy
    @instagramposter.destroy
    respond_to do |format|
      format.html { redirect_to [:admin, instagramposters_url], notice: 'Instagramposter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instagramposter
      @instagramposter = Instagramposter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instagramposter_params
      params.require(:instagramposter).permit(:ig_id, :screen_name, :artist_id, :profile_image,:remote_profile_image_url)
    end
end
end