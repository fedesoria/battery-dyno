class User < ActiveRecord::Base
  has_many :requests
  
  
  def get_data_points
    output_dynos = "["
    small_req = requests.where({:date => (Time.now - 7.days)..Time.now}).select("date, start")
    output_req  = "["
    temp_date = small_req.first.date
    temp_time = small_req.first.start
    small_req.each do |req|
      if temp_date.strftime('%m-%d-%H-%M') == req.date.strftime('%m-%d-%H-%M')
        temp_time += req.start
      else
        output_req << "[#{req.date.to_i * 1000}, #{temp_time}],"
        output_dynos << "[#{req.date.to_i * 1000}, #{temp_time.ceil}],"
        temp_time = req.start
        temp_date = req.date
      end
    end
    output_dynos = output_dynos.chop
    output_req = output_req.chop
    output_dynos << "]"
    output_req << "]"
    return [output_req, output_dynos]
  end
  
  
end


