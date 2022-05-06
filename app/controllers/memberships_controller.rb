class MembershipsController < ApplicationController
  before_action :get_headquarter
  before_action :set_membership, only: %i[ show edit update destroy ]

  # GET /memberships or /memberships.json
  def index
    @memberships = @headquarter.memberships
  end

  # GET /memberships/1 or /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = @headquarter.memberships.build
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships or /memberships.json
  def create
    @membership = @headquarter.memberships.build(membership_params)

    respond_to do |format|
      if @membership.save
        format.html { redirect_to headquarter_memberships_path(@headquarter), notice: "Membership was successfully created." }
        format.json { render :show, status: :created, location: @membership }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1 or /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to headquarter_channel_path(@headquarter), notice: "Membership was successfully updated." }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1 or /memberships/1.json
  def destroy
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to headquarter_channels_path(@headquarter), notice: "Membership was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def get_headquarter
      @headquarter = Headquarter.find(params[:headquarter_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = @headquarter.memberships.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def membership_params
      params.require(:membership).permit(:invitation_email, :autorenewal, :is_active, :role_id, :user_id, :headquarter_id, :channel_id)
    end
end
