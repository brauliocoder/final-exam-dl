class FriedmanController < ApplicationController
  before_action :set_channel, only: %i[ cashbox_mode ]

  def index
  end

  def cashbox_mode
  end

  private
    def set_channel
      @channel = current_user.find_channel.(params[:channel_id])
    end
end
