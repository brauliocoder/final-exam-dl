class ChannelsController < ApplicationController
  before_action :authenticate_user!

  before_action :get_headquarter
  before_action :set_channel, only: %i[ show edit update destroy connect_members ]

  # GET /channels or /channels.json
  def index
    @channels = @headquarter.channels
  end

  # GET /channels/1 or /channels/1.json
  def show
  end

  # GET /channels/new
  def new
    @channel =  @headquarter.channels.build
  end

  # GET /channels/1/edit
  def edit
  end

  def connect_members
  end
  

  # POST /channels or /channels.json
  def create
    @channel =  @headquarter.channels.build(channel_params)

    respond_to do |format|
      if @channel.save
        format.turbo_stream
        format.html { redirect_to headquarter_channels_path(@headquarter), notice: "Channel was successfully created." }
        format.json { render :show, status: :created, location: @channel }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /channels/1 or /channels/1.json
  def update
    respond_to do |format|
      if @channel.update(channel_params)
        format.turbo_stream
        format.html { redirect_to headquarter_channel_path(@headquarter), notice: "Channel was successfully updated." }
        format.json { render :show, status: :ok, location: @channel }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /channels/1 or /channels/1.json
  def destroy
    @channel.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to headquarter_channels_path(@headquarter), notice: "Channel was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def get_headquarter
      @headquarter = Headquarter.find(params[:headquarter_id])
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = @headquarter.channels.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def channel_params
      params.require(:channel).permit(:name, :description, :is_active, :headquarter_id, warehouse_ids: [], membership_ids: [])
    end
end
