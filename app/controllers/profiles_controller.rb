class ProfilesController < ApplicationController
  skip_before_action :profile_exist?
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = current_user.profile
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @following_user = @profile.user
    @total_following = Following.where(user_id: current_user.id, is_following: true)
    @total_followers = Following.where(following_user_id: current_user.id, is_following: true)
    @following_size = @total_following.size
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :about_me, :date_of_birth, :profile_image, :user_id)
    end

end
