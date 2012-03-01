require 'sinatra'
require 'sinatra/documentation'

get '/foo/bar' do
  "Hello World"
end

get '/' do
  'some shit'
end
