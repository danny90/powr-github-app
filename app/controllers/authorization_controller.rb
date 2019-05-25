class AuthorizationController < ApplicationController
  def index
    @body = HTTP.headers(:accept => "application/json")
      .post("https://github.com/login/oauth/access_token?client_id=aca4a339f865678aef37&client_secret=f00ea7d128bbfa1c555c7647b7cd5826bfc27059&code=#{params[:code]}").to_s
    @access_token = JSON.parse(@body)['access_token']
    @response = JSON.parse(HTTP.auth("Bearer #{@access_token}")
      .get("https://api.github.com/user"))
    
    if !@response['message']
      # Add new entry to db
      puts 'SUCCESS'
    end
    redirect_to controller: :home, action: :index
  end
end
