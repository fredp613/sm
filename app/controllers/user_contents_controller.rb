class UserContentsController < ApplicationController
  before_action :set_user_content, only: [:show, :edit, :update, :destroy]

  # GET /user_contents
  # GET /user_contents.json
  def index

    if params[:artist_id]
      @contents = Content.favorites(current_user).where(artist_id: params[:artist_id]).page(params[:page]).per(10)
    else
      @contents = Content.favorites(current_user).all.page(params[:page]).per(10)
    end
  
  end

  def user_contents_count
    @count = Content.favorites(current_user).count
    render json: @count
  end

  # GET /user_contents/1
  # GET /user_contents/1.json
  def show
  end

  # GET /user_contents/new
  def new
    @user_content = UserContent.new
  end

  # GET /user_contents/1/edit
  def edit
  end

  # POST /user_contents
  # POST /user_contents.json
  def create
    @user_content = UserContent.new(user_content_params)
    
    if params[:scoped]
      @contents = Content.by_artist(params[:user_content][:artist_id]).page(params[:page]).per(10)
    elsif params[:scoped_favorite]
      @contents = Content.favorites(current_user).page(params[:page]).per(10)
      
    else
      @contents = Content.all.page(params[:page]).per(10)
    end
    

     if @user_content.save
      respond_to do |format|
        set_counts      
       
        if params[:scoped]
          format.html { redirect_to user_artists_path, notice: 'Favorite was successfully created.' }
        elsif params[:scoped_favorite]
          format.html { redirect_to user_contents_path, notice: 'Favorite was successfully created.' }
        else
          format.html { redirect_to home_index_path, notice: 'Favorite was successfully created.' }
        end
        format.json { render json: @user_content }
        format.js
      end
       
       # render json: @user_artist
      else
        # format.html { render :new }
        # format.json { render json: @user_artists.errors, status: :unprocessable_entity }
        render json: @user_artist.errors
      end
  end

  # PATCH/PUT /user_contents/1
  # PATCH/PUT /user_contents/1.json
  def update
    respond_to do |format|
      if @user_content.update(user_content_params)
        format.html { redirect_to @user_content, notice: 'User content was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_content }
      else
        format.html { render :edit }
        format.json { render json: @user_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_contents/1
  # DELETE /user_contents/1.json
  def destroy
    @user_artists = current_user.artists.all.page(params[:page]).per(10)
    
    if params[:scoped]
      @contents = Content.by_artist(params[:artist_id]).page(params[:page]).per(10)
    elsif params[:scoped_favorite]
      if params[:artist_id]
        @contents = Content.favorites(current_user).where(artist_id: params[:artist_id]).page(params[:page]).per(10)
      else
        @contents = Content.favorites(current_user).page(params[:page]).per(10)
      end

    else
      @contents = Content.all.page(params[:page]).per(10)
    end


   if @user_content.destroy

      respond_to do |format|
        set_counts
        if params[:scoped]
          format.html { redirect_to user_artists_path, notice: 'Favorite was successfully destroyed.' }
        elsif params[:scoped_favorite]
          format.html { redirect_to user_contents_path, notice: 'Favorite was successfully destroyed.' }
        else
          format.html { redirect_to home_index_path, notice: 'Favorite was successfully destroyed.' }
        end

        format.json { render json: @user_content }      
        format.js
      end
        # render json: @user_content
    else
      render json: @user_content.errors
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_content
      @user_content = UserContent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_content_params
      params.require(:user_content).permit(:user_id, :content_id, :scoped)
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
