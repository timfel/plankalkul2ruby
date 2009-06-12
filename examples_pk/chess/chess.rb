require 'sinatra'
require 'haml'
require 'json'
require 'pkchess'

class ChessGame < Sinatra::Default
   @@chess = PKChess.new
   @@moves = []

   get '/' do
      haml :index, {}, :blah => 10
   end

   get '/select/:x/:y' do
      @@chess.select(params[:x],params[:y]).to_json
   end

   get '/move/:x1/:y1/to/:x2/:y2' do
      #"Set #{params[:x1]}@#{params[:y1]} to #{params[:x2]}@#{params[:y2]}"
      m=[params[:x1].to_i,params[:y1].to_i,params[:x2].to_i,params[:y2].to_i]
      if @@chess.move(params[:x1],params[:y1],params[:x2],params[:y2])
	 @@moves << m
	 r = true
      else
	 r = false
      end
      r.to_json
   end

   get '/replay/:i' do
      r = @@moves[params[:i].to_i] || false
      r.to_json
   end

   def update_clients
      @@clients
   end
end

ChessGame.run!
exit
