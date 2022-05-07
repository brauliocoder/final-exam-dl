class FriedmanController < ApplicationController
  before_action :set_channel, only: %i[ cashbox_mode ]

  def index
  end

  def cashbox_mode
    @order = current_order
  end

  private
    def set_channel
      @channel = Channel.find(params[:channel_id])
    end

    def current_order
      order = Order.where(channel_id: @channel.id).where(is_completed: false).last
      if order.nil?
        order = Order.create(channel_id: @channel.id)
      end
      
      return order
    end
    
end
