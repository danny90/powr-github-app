class HomeController < ApplicationController
    def index
        @histories = LoginHistory.order(created_at: :desc).first(10)
        render :history_list, :locals => {:histories => @histories}
    end

    def show
      render :index, :locals => {:client_id => ENV['CLIENT_ID'], :login => LOGIN_USERNAME, :allow_signup => ALLOW_SIGNUP}
    end
end