class HomeController < ApplicationController
    def index
        @histories = LoginHistory.order(created_at: :desc).first(10)
        render :history_list, :locals => {:histories => @histories}
    end

    def show
      render :index
    end
end