# Allow the metal piece to run in isolation
require File.expand_path('../../../config/environment',  __FILE__) unless defined?(Rails)

class RequestsCall
  
  def self.call(env)
    # status, headers, response = @app.call(env) 
    req = Rack::Request.new(env)
    @params = req.params
    
    if env["PATH_INFO"] =~ /^\/heroku/ && env["REQUEST_METHOD"] == "POST" && user = User.find_by_name(@params["name"])
          
        if @params["dyno"]
          Request.create(:user_id => user.id, :date => @params["date"], :start => @params["time"], :dynos => @params[:dyno])
        else
          Request.create(:user_id => user.id, :date => @params["date"], :start => @params["time"])
        end
      [200, {"Content-Type" => "text/html"}, ["OK"]]
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end
  
end