require 'sinatra'

set :port, ENV['VCAP_APP_PORT'] || 4567

get '/' do
  "<html><head><title>ruby_buildpack</title></head><body>OK!</body></html>"
end