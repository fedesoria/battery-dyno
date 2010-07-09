class User < ActiveRecord::Base
  has_many :requests
  
  def get_data_points
    output_dynos = "["
    small_req = requests.where({:date => (Time.now - 7.days)..Time.now + 7.hours}).select("date, start,dynos")
    output_req  = "["
    temp_date = small_req.first.date
    temp_time = small_req.first.start
    temp_dynos = 1
    small_req.each do |req|
      if temp_date.strftime('%m-%d-%H-%M') == req.date.strftime('%m-%d-%H-%M')
        temp_time += req.start
        temp_dynos = req.dynos
      else
        output_req << "[#{temp_date.to_i * 1000}, #{temp_time}],"
        output_dynos << "[#{temp_date.to_i * 1000}, #{temp_dynos}],"
        temp_time = req.start
        temp_date = req.date
        temp_dynos = req.dynos
      end
    end
    unless output_dynos.size == 1
      output_dynos = output_dynos.chop
    end
    unless output_req.size == 1
      output_req = output_req.chop
    end
    output_dynos << "]"
    output_req << "]"
    return [output_req, output_dynos]
  end
  
  
end
