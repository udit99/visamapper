class SessionsController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth']
    @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    if @authorization
      session[:user_id] = @authorization.user.id
      redirect_to "/"
    else
      user = User.new :name => auth_hash[:extra][:raw_info][:name], :email => auth_hash[:extra][:raw_info][:email]
      user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
      user.save
      session[:user_id] = user.id
      redirect_to "/"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/"
  end

end
