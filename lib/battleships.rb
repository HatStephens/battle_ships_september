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
    @name = session[:something]
  	erb :new_game
  end

  get '/create_player' do
  	flash[:error] = "You need to pass a name."
  	@name = params['name']
    session[:name] = @name
    player = Player.new
  	player.name= @name
    GAME.add_player(player)
    if @name==""
      redirect '/new_game'
    else
      redirect '/show_board'
    end
  end

  get '/show_board' do
    redirect '/place_ships' if GAME.has_two_players?
    @name = session[:name]
    @board = Board.new(Cell)
    erb :show_board
  end


  # post '/show_board_player_two' do
  #   flash[:error] = "You need to pass a name."
  #   redirect '/show_board_player_one' if  params['name'] == ''
  #   session[:me] = params['name']
  #   @player_two = Player.new
  #   @player_two.name= params['name']
  #   session[:name] = @player_two.name
  #   @board_two = Board.new(Cell)
  #   erb :show_board_player_two
  # end

  run! if app_file == $0

end
