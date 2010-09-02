require 'net/http'
require 'uri'

id = ENV['DYNOBATTERY_URL']
puts "Connecting to account #{id}"

begin
  uri = URI.parse('http://dyno-battery.heroku.com')
  http = Net::HTTP.new(uri.host, uri.port)
  response = http.head('/users/' + id.to_s)
  # response = Net::HTTP.get(URI.parse('http://localhost:3000/users/' + id))
  puts "The dyno battery for this account is: #{response.message}"
rescue => e
  abort "Failed to load dyno battery: #{e.message}"
end
