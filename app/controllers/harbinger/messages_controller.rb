module Harbinger
  class MessagesController < ActionController::Base

    def index
      @messages = DatabaseChannelMessage.search(q: params[:q])
    end

    def show
      @message = DatabaseChannelMessage.find(params[:id])
    end
  end
end
