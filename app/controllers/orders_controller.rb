class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]
  before_action :set_channel, only: %i[ cashbox_mode add_product ]
  before_action :select_or_create_current_order, only: %i[ cashbox_mode add_product ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  def cashbox_mode
    @products = @channel.search_product(params[:search])
  end

  def add_product
    @product = @channel.find_product(params[:product_id])
    @sale = Sale.new(order_id: @order.id, space_id: @product.id, quantity: 1, price: @product.price)
    @sale.save
  end
  
  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_channel
      @channel = Channel.find(params[:channel_id])
    end

    def select_or_create_current_order
      @order = Order.where(channel_id: @channel.id).where(is_completed: false).last
      if @order.nil?
        @order = Order.create(channel_id: @channel.id)
      end
    end

    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:is_completed, :membership_id, :channel_id, :product_id, sale_ids: [])
    end
end
