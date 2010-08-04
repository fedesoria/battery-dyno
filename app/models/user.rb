class User < ActiveRecord::Base
  has_many :requests
  
  def self.alert_on_red(id)
    user = User.find(id)
    if user.email
      dynos = user.requests.last.dynos
      requests = user.requests.where(["date > ?",Time.now - 1.minute])
      total_time = 0
      requests.map { |x| total_time += x.start }
      percentage = (total_time/60 * 1000)/(dynos * 1000)
      if percentage > 0.80
        Notifier.alert_email(user, percentage).deliver
      end
    end
  end
  
  
  def get_data_points
    output_dynos = "["
    small_req = requests.where({:date => (Time.now - 7.days)..Time.now + 7.hours}).select("date, start,dynos")
    output_req  = "["
    if small_req.first
      temp_date = small_req.first.date
      temp_time = small_req.first.start
    else
        temp_date = Time.now
        temp_time = Time.now
    end
    temp_dynos = 1
    small_req.each do |req|
      if temp_date.strftime('%m-%d-%H-%M') == req.date.strftime('%m-%d-%H-%M')
        temp_time += req.start
        temp_dynos = req.dynos
      else
        output_req << "[#{temp_date.to_i * 1000}, #{temp_time/60}],"
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
