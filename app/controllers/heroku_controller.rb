class HerokuController < UsersController
  before_filter :authenticate_heroku


  protected
    def authenticate_heroku
      authenticate_or_request_with_http_basic do |user, password|
        user == 'heroku' && password == 'Wtn8OwjlMHJwC4oL'
      end
    end
end
