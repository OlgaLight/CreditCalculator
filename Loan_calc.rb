$LOAD_PATH.unshift *Dir["#{File.dirname(__FILE__)}/"]

require 'rubygems'
require 'sinatra'
require 'Calculator'

get '/' do
  @title = 'Online credit calculator'
  erb :index
end

post '/results' do
  erb :results, :locals => {:params => request.POST}
end
