require 'net/http'
require 'uri'

id = ENV['DYNOBATTERY_ID']
puts "Connecting to account #{id}"

begin
  uri = URI.parse('http://dyno-battery.heroku.com')
  http = Net::HTTP.new(uri.host, uri.port)
  response = http.head('/users/' + id.to_s)
  puts "The dyno battery for this account is: #{response.message}"
rescue => e
  abort "Failed to load dyno battery: #{e.message}"
end
