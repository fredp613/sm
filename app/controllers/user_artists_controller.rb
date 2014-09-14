class UserArtistsController < ApplicationController
  before_action :set_user_artist, only: [:show, :edit, :update, :destroy]
  before_filter :set_counts
  # after_filter :set_content, only: [:create, :destroy]

  # GET /user_artists
  # GET /user_artists.json
  def index
    # @user_artists = current_user.user_artists.page(params[:page]).per(10)
    if params[:artist_id]
      @contents = Content.artists(current_user).where(artist_id: params[:artist_id]).page(params[:page]).per(10)
    else
      @contents = Content.artists(current_user).all.page(params[:page]).per(10)
    end
       
  end

  def artist_index
    @user_artists = current_user.artists.all.page(params[:page]).per(10)
    if params[:scoped]
      @contents = Content.by_artist_for_user_collection(current_user).all.page(params[:page]).per(21)
    end
  end  
  

  def user_artists_count
    @count = current_user.artists.count    
    render json: @count
  end

  # GET /user_artists/1
  # GET /user_artists/1.json
  def show
  end

  # GET /user_artists/new
  def new
    @user_artist = UserArtist.new
  end

  # GET /user_artists/1/edit
  def edit
  end

  # POST /user_artists
  # POST /user_artists.json
  def create
    @user_artist = UserArtist.new(user_artist_params)
    @contents = Content.all.page(params[:page]).per(10)
     # @count_artists = current_user.artists.count 
    
    if @user_artist.save
      respond_to do |format|
        set_counts
        @content = Content.where(id: params[:content_id]).first
        format.html { redirect_to root_url, notice: 'Artist was successfully created.' }
        format.json { render json: @user_artist }
        format.js
      end
       
       # render json: @user_artist
      else
        # format.html { render :new }
        # format.json { render json: @user_artists.errors, status: :unprocessable_entity }
        render json: @user_artist.errors
      end
  end

  # PATCH/PUT /user_artists/1
  # PATCH/PUT /user_artists/1.json
  def update
    respond_to do |format|
      if @user_artist.update(user_artist_params)
        format.html { redirect_to @user_artist, notice: 'User artist was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_artist }
      else
        format.html { render :edit }
        format.json { render json: @user_artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_artists/1
  # DELETE /user_artists/1.json
  def destroy
     @user_artists = current_user.artists.all.page(params[:page]).per(10)
     # @contents = Content.all.page(params[:page]).per(10)
    
     if params[:scoped]
      @contents = Content.by_artist_for_user_collection(current_user).all.page(params[:page]).per(21)
     else
      @contents = Content.all.page(params[:page]).per(10)
     end

    if @user_artist.destroy
        respond_to do |format|
          set_counts
          @content = Content.where(id: params[:content_id]).first
          format.html { redirect_to home_index_path, notice: 'Artist was successfully destroyed.' }
          format.json { render json: @user_artist }      
          format.js
        end
      
      # render json: @user_artist
    else
      render json: @user_artist.errors
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_artist
      if params[:user_id] && params[:artist_id]
        @user_artist = UserArtist.find_by_user_artist(user_id: params[:user], artist_id: params[:artist_id])
      else
        @user_artist = UserArtist.find(params[:id])
      end

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_artist_params
      params.require(:user_artist).permit(:user_id, :artist_id, :scoped, :user_artists_attributes, :artists_attributes)
    end

    def set_content
      @content = Content.where(id: params[:content_id]).first
    end

    def set_counts
      if user_signed_in?
        @count_artists = current_user.artists.count
        @count_favorites = Content.favorites(current_user).count
      else
        @count_artists = ""
        @count_favorites = ""
      end 
    end
end
