namespace :events do
  require 'net/http'

  task :create => :environment do
    # uri = URI.parse('http://api.dev.com:3000')
    # http = Net::HTTP.new(uri.host, uri.port)
    # request = Net::HTTP::Post.new('/v1/events')
    # request.add_field('Content-Type', 'application/json')
    # request.body = {event:  {execute_at: Time.new(0, 1, 1, 0, 0, 0, 0), command: "echo 'Hello World' #{Random.rand(500)}"}}
    # response = http.request(request)
    # puts response.body


    # uri = URI.parse('http://api.dev.com:3000/v1/events')
    # event = {event:  {execute_at: Time.new(0, 1, 1, 0, 0, 0, 0), command: "echo 'Hello World' #{Random.rand(500)}"}}.to_json
    # response = Net::HTTP.post_form(uri, event)
    # puts response.body

    uri = URI.parse('http://api.dev.com:3000/v1/events')
    https = Net::HTTP.new(uri.host,uri.port)
    # header = {'Content-Type' => 'text/json'}
    req = Net::HTTP::Post.new(uri.path)
    req.add_field('Content-Type', 'application/json')
    event = { execute_at: Time.new(0, 1, 1, 0, 0, 0, 0), command: "echo 'Hello World' #{Random.rand(500)}" }
    # event = {event: { execute_at: Time.new(0, 1, 1, 0, 0, 0, 0), command: "echo 'Hello World' #{Random.rand(500)}" } }
    # req.body = "event=#{event.to_json}"
    # req.body = "event=#{event.to_json}"
    # req['event'] = event.to_json
    req.body = event.to_json
    res = https.request(req)
    puts res.body
  end

  task :list => :environment do
    uri = URI.parse('http://api.dev.com:3000')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new('/v1/events')
    request.add_field('Content-Type', 'application/json')
    response = http.request(request)
    puts response.body
  end
end