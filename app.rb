
require 'sinatra'
require 'sinatra/activerecord'

configure(:development){set :database, "sqlite3:blog.sqlite3"}
require './models'

require 'bundler/setup'
require 'rack-flash'

enable :sessions
use Rack::Flash, :sweep => true
set :sessions, true

get '/' do
	puts "Loading up the home page and sign in"
	erb :home
end

get '/signup' do
	erb :signup
end

post '/submit_user' do
	puts params.inspect
	user_info = params[:user]
	User.create(user_info)
	current_user
	erb :post
end

get '/login-failed' do
	erb :fail
end

get '/post' do
	erb :post
	current_user
end

post '/sign-in' do     
	puts "my params are" + params.inspect
	@user = User.where(username: params[:username]).first
	puts @user.inspect
	if @user.password == params[:password]
		erb :post
	else
		flash[:alert] = "Please try again."     
		redirect '/login-failed'   
	end    
end

post '/submit_post' do
	@info = params[:post]
	current_post = Post.create(@info)
	current_post.user = current_user.id
	current_post.save
end

def current_user     
	if session[:user_id]       
		@current_user = User.find(session[:user_id])     
	end   
end