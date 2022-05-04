class SpacesController < ApplicationController
  before_action :get_warehouse
  before_action :set_space, only: %i[ show edit update destroy ]

  # GET /spaces or /spaces.json
  def index
    @spaces = @warehouse.spaces
  end

  # GET /spaces/1 or /spaces/1.json
  def show
  end

  # GET /spaces/new
  def new
    @space = @warehouse.spaces.build
  end

  # GET /spaces/1/edit
  def edit
  end

  # POST /spaces or /spaces.json
  def create
    @space = @warehouse.spaces.build(space_params)

    respond_to do |format|
      if @space.save
        format.html { redirect_to warehouse_spaces_url(@warehouse), notice: "Space was successfully created." }
        format.json { render :show, status: :created, location: @space }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spaces/1 or /spaces/1.json
  def update
    respond_to do |format|
      if @space.update(space_params)
        format.html { redirect_to warehouse_space_url(@warehouse), notice: "Space was successfully updated." }
        format.json { render :show, status: :ok, location: @space }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spaces/1 or /spaces/1.json
  def destroy
    @space.destroy

    respond_to do |format|
      format.html { redirect_to warehouse_spaces_url(@warehouse), notice: "Space was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def get_warehouse
      @warehouse = Warehouse.find(params[:warehouse_id])
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_space
      @space = @warehouse.spaces.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def space_params
      params.require(:space).permit(:stock, :price, :expiration, :warehouse_id, :product_id)
    end
end
