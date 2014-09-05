module Admin
  class ArtistsController < ApplicationController
    

    # http_basic_authenticate_with name: Rails.application.secrets.admin_name, password: Rails.application.secrets.admin_password
    before_filter :admin_authentication

    before_action :set_artist, only: [:show, :edit, :update, :destroy]

    # GET /artists
    # GET /artists.json
    def index
      @artists = Artist.all
    end

    # GET /artists/1
    # GET /artists/1.json
    def show

      respond_to do |format|
        format.html
        format.json { render json: @artist.id }      
      end
    end

    # GET /artists/new
    def new
      @artist = Artist.new
      @artist.twitterposters.build
      @artist.instagramposters.build
    end

    # GET /artists/1/edit
    def edit
      
    end

    # POST /artists
    # POST /artists.json
    def create
      @artist = Artist.new(artist_params)

      respond_to do |format|
        if @artist.save
          format.html { redirect_to [:admin, @artist], notice: 'Artist was successfully created.' }
          format.json { render :show, status: :created, location: @artist }
        else
          format.html { render :new }
          format.json { render json: @artist.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /artists/1
    # PATCH/PUT /artists/1.json
    def update
      respond_to do |format|
        if @artist.update(artist_params)
          format.html { redirect_to [:admin, @artist], notice: 'Artist was successfully updated.' }
          format.json { render :show, status: :ok, location: @artist }
        else
          format.html { render :edit }
          format.json { render json: @artist.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /artists/1
    # DELETE /artists/1.json
    def destroy
      @artist.destroy
      respond_to do |format|
        format.html { redirect_to admin_artists_url, notice: 'Artist was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_artist
        @artist = Artist.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def artist_params
        params.require(:artist).permit(:artist_name, :first_name, :last_name, 
          :twitterposters_attributes => [:id, :user_id, :screen_name, :artist_id, :profile_image, :remote_profile_image_url], 
          :instagramposters_attributes => [:id, :ig_id, :screen_name, :artist_id, :profile_image,:remote_profile_image_url])
      end
  end
end