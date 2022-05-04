class HeadquartersController < ApplicationController
  before_action :set_headquarter, only: %i[ show edit update destroy ]

  # GET /headquarters or /headquarters.json
  def index
    @headquarters = Headquarter.all
  end

  # GET /headquarters/1 or /headquarters/1.json
  def show
  end

  # GET /headquarters/new
  def new
    @headquarter = Headquarter.new
  end

  # GET /headquarters/1/edit
  def edit
  end

  # POST /headquarters or /headquarters.json
  def create
    @headquarter = Headquarter.new(headquarter_params)

    respond_to do |format|
      if @headquarter.save
        format.html { redirect_to headquarter_url(@headquarter), notice: "Headquarter was successfully created." }
        format.json { render :show, status: :created, location: @headquarter }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @headquarter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /headquarters/1 or /headquarters/1.json
  def update
    respond_to do |format|
      if @headquarter.update(headquarter_params)
        format.html { redirect_to headquarter_url(@headquarter), notice: "Headquarter was successfully updated." }
        format.json { render :show, status: :ok, location: @headquarter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @headquarter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /headquarters/1 or /headquarters/1.json
  def destroy
    @headquarter.destroy

    respond_to do |format|
      format.html { redirect_to headquarters_url, notice: "Headquarter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_headquarter
      @headquarter = Headquarter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def headquarter_params
      params.require(:headquarter).permit(:brand, :is_active, :user_id)
    end
end
