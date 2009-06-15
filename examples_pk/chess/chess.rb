require 'sinatra'
require 'haml'
require 'json'
require 'pkchess'

class ChessGame < Sinatra::Default

   def initialize
      @@chess = PKChess.new
      @@moves = []
      @@players = 0
   end

   get '/' do
      initialize if @@players == 2
      haml :index, {}, :blah => 10
   end

   get '/select/:color/:x/:y' do
      @@chess.select(params[:x],params[:y],params[:color]).to_json
   end

   get '/move/:color/:x1/:y1/to/:x2/:y2' do
      #"Set #{params[:x1]}@#{params[:y1]} to #{params[:x2]}@#{params[:y2]}"
      m=[params[:x1].to_i,params[:y1].to_i,params[:x2].to_i,params[:y2].to_i]
      if @@chess.move(params[:x1],params[:y1],params[:x2],params[:y2],params[:color])
	 @@moves << m
	 r = true
      else
	 r = false
      end
      r.to_json
   end

   get '/delete/:color/:x/:y' do
      @@chess.delete(params[:x],params[:y],params[:color]).to_json
   end

   get '/replay/:i' do
      r = @@moves[params[:i].to_i] || false
      r.to_json
   end

   get '/color' do
      if @@players == 0
	 @@players = 1
	 0.to_json
      else
	 @@players = 2
	 1.to_json
      end
   end

   def update_clients
      @@clients
   end
end

ChessGame.run!
exit
