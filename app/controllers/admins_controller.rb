class AdminsController < ApplicationController
  before_action :logged_in_admin, only: [:index, :edit, :update, :destroy]
  before_action :set_admin,       only: [:show, :edit, :update, :destroy]
  before_action :correct_admin,   only: [:edit, :update]

  layout "admin"
  
  def dashboard
    
  end
  
  def index
    @admins = Admin.all
  end

  def show
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      log_in_admin @admin
      flash[:success] = "Admin created"
      redirect_to @admin
    else
      render 'new'
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:name, :email, :password, :password_confirmation)
    end
    
    # Confirms a logged-in partner.
    def correct_admin
      #@admin = Partner.find(params[:id])
      redirect_to(root_url) unless current_admin?(@admin)
    end
end