require 'heroku/nav'

class HerokuController < UsersController
  before_filter :authenticate_heroku, :except => [:login, :dashboard]
  
  def login
    pre_token = params[:id] + ':' + HEROKU_SSO_SALT + ':' + params[:timestamp]
    token = Digest::SHA1.hexdigest(pre_token).to_s
    
    if token != params[:token] or params[:timestamp].to_i < (Time.now - 2*60).to_i
      render :text => "Forbidden.", :status => 403
    else
      user = User.find(params[:id])
      unless user
        render :text => "Account doesn't exist.", :status => 404
      else
        session[:user] = user.id
        session[:heroku_sso] = true
        cookies['heroku-nav-data'] = params['nav-data']
        redirect_to :action => "dashboard"
      end
    end
  end

  def dashboard
    # render :text => "Dashboard IN"
  end


  protected
    def authenticate_heroku
      authenticate_or_request_with_http_basic do |user, password|
        user == 'heroku' && password == 'OBBxxyoDE7HyEIAY'
      end
    end
end
