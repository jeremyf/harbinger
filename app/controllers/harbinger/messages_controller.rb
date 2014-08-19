module Harbinger
  class MessagesController < ApplicationController

    def index
      messages
    end

    def show
      message
    end

    protected

    def messages
      @messages ||= DatabaseChannelMessage.page(params[:page]).search(q: params[:q])
    end

    def message
      @message ||= DatabaseChannelMessage.find(params[:id])
    end

    helper_method :message, :messages
  end
end
