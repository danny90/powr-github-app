require "base64"

class AuthorizationController < ApplicationController
  def index
    @response1 = HTTP.headers(:accept => "application/json")
      .post("https://github.com/login/oauth/access_token?client_id=#{ENV['CLIENT_ID']}&client_secret=#{ENV['CLIENT_SECRET']}&code=#{params[:code]}").to_s
    @access_token = JSON.parse(@response1)['access_token']
    @response2 = JSON.parse(HTTP.auth("Bearer #{@access_token}").get("https://api.github.com/user"))

    @response3 = JSON.parse(HTTP.get("https://api.github.com/repos/#{LOGIN_USERNAME}/#{LOGIN_USERNAME}.github.io/contents/index.html"))
    @sha = @response3['sha']
    @content = Base64.decode64(@response3['content'])
    @insert_index = @content.index('</head>')
    @content = @content.insert(@insert_index, "  #{ADD_TO_HEAD}\n  ")
    @insert_index = @content.index('</body>')
    @content = @content.insert(@insert_index, "  #{ADD_TO_BODY}\n  ")
    @content_base64 = Base64.encode64(@content)
    @body = {
      message: "Adding snippets",
      sha: @sha,
      content: @content_base64,
      committer: {
        name: @response2['name'],
        email: @response2['email']
      }
    }
    @response4 = HTTP.auth("Bearer #{@access_token}")
      .put("https://api.github.com/repos/#{LOGIN_USERNAME}/#{LOGIN_USERNAME}.github.io/contents/index.html", json: @body)

    if !@response2['message']
      # Add new entry to db
      # Since 'type' is not allowed as a column and 'created_at'/'updated_at' fields are the same with
      # generated columns, response fields are mapped to different columns
      LoginHistory.create({:login => @response2['login'], :user_id => @response2['id'],
        :avatar_url => @response2['avatar_url'], :url => @response2['url'], :repos_url => @response2['repos_url'],
        :user_type => @response2['type'], :name => @response2['name'], :company => @response2['company'],
        :location => @response2['location'], :email => @response2['email'], :public_repos => @response2['public_repos'],
        :user_created_at => @response2['created_at'], :user_updated_at => @response2['updated_at'],
        :disk_usage => @response2['disk_usage']})
    end
    redirect_to controller: :home, action: :index
  end
end
