class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: %i[ show edit update destroy ]
  before_action :set_channel, only: %i[ cashbox_mode add_product remove_product remove_all_item end_transaction ]
  before_action :set_product, only: %i[ cashbox_mode add_product remove_product remove_all_item ]
  before_action :select_or_create_current_order, only: %i[ cashbox_mode add_product remove_product remove_all_item end_transaction ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  def cashbox_mode
    @products = @channel.search_product(params[:search])

    case params[:m_nav]
    when 'history'
      respond_to do |format|
        format.turbo_stream { render "orders/turbo_stream/modes/history_mode" }
      end
    when 'stats'
      respond_to do |format|
        format.turbo_stream { render "orders/turbo_stream/modes/stats_mode" }
      end
    when 'default'
      respond_to do |format|
        format.turbo_stream { render "orders/turbo_stream/modes/default_mode" }
      end
    end
  end

  def add_product
    @sale = @channel.add_product(@order, @product)
    respond_to do |format|
      format.turbo_stream { render "orders/turbo_stream/product_update" }
    end
  end

  def remove_product
    @sale = @channel.remove_product(@order, @product)
    respond_to do |format|
      format.turbo_stream { render "orders/turbo_stream/product_update" }
    end
  end

  def remove_all_item
    @sale = @channel.remove_product(@order, @product, remove_all = true)
    respond_to do |format|
      format.turbo_stream { render "orders/turbo_stream/product_update" }
    end
  end

  def end_transaction
    if @order.sales.count > 0
      if params[:transaction_flag] == 'save'
        @order.is_completed = true
        @order.save
      elsif params[:transaction_flag] == 'discard'
        @order.destroy
      end
      
      redirect_to cashbox_mode_path(@order)
    end
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

    def set_product
      @product = @channel.find_product(params[:product_id])
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
