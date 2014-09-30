require 'sinatra/base'
require 'rack-flash'
require_relative 'board'
require_relative 'cell'
require_relative 'player'
require_relative 'game'

class BattleShips < Sinatra::Base

	set :views, Proc.new { File.join(root, '..', "views") }
	enable :sessions
	use Rack::Flash

	GAME = Game.new
  
  get '/' do
    erb :index
  end

  get '/new_game' do
  	
  	erb :new_game
  end

  post '/show_board' do
  	flash[:error] = "You need to pass a name."
  	redirect '/new_game' if  params['name'] == ''
  	@player_one = Player.new
  	@player_one.name= params['name']
  	session[:name] = @player_one.name
  	@board_one = Board.new(Cell)
  	erb :show_board
  end

  run! if app_file == $0

end
