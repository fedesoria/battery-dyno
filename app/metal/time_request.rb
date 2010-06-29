# Allow the metal piece to run in isolation
require File.expand_path('../../../config/environment',  __FILE__) unless defined?(Rails)

class TimeRequest
  
  def self.call(env)
    req = Rack::Request.new(env)
    @params = req.params
    
    if env["PATH_INFO"] =~ /^\/heroku_time/ && @params["id"]
      requests = User.find(@params["id"]).requests.where(["date > ?",Time.now - 1.minute + 7.hours])
      if requests.empty?
        [200, {"Content-Type" => "text/html"}, ["0"]]
      else  
        total_time = 0
        requests.map { |x| total_time += x.start }
        [200, {"Content-Type" => "text/html"}, ["#{total_time/60 * 1000}"]]
      end
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end
  
end
