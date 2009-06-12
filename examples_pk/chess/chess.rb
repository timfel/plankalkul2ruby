require 'sinatra'
require 'haml'
require 'json'
require 'pkchess'

#use Rack::Auth::Basic do |username, password|
#   username == 'admin' && password == 'secret'
#end

get '/' do
   haml :index, {}, :blah => 10
end

get '/select/:x/:y' do
   PKChess.new.select(params[:x],params[:y]).to_json
end

get '/move/:x1/:y1/to/:x2/:y2' do
   #"Set #{params[:x1]}@#{params[:y1]} to #{params[:x2]}@#{params[:y2]}"
   true.to_json
end
