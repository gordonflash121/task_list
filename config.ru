# Rack environment for testing purposes

require 'coffee-script'
require 'json'
require 'sprockets'

Root = File.expand_path("..", __FILE__)

Assets = Sprockets::Environment.new(Root) do |env|
  env.append_path "components" # bower
  env.append_path "app/assets"
end

map "/assets" do
  run Assets
end

map "/update" do
  run lambda { |env|
    req = Rack::Request.new(env)
    [200, {'Content-Type' => 'application/json'}, [req.params.to_json]]
  }
end

map "/" do
  run Rack::Directory.new(Root)
end
