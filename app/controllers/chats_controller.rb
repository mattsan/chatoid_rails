class ChatsController < ApplicationController
  def show
    @name = params[:id]
  end
end
