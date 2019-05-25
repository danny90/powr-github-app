class HomeController < ApplicationController
    def index
        render :list
    end

    def show
      render :index, :locals => {:login => params[:login], :client_id => params[:id]}
    end

    private

    def entry_params
        params.require(:entry).permit(:login)
    end
end