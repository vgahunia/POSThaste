
require 'sinatra'
require 'sinatra/activerecord'

configure(:development){set :database, "sqlite3:blog.sqlite3"}
require './models'

require 'bundler/setup'
require 'rack-flash'

enable :sessions
use Rack::Flash, :sweep => true
set :sessions, true

#---------- METHODS ------------

def current_user     
	if session[:user_id]       
		@current_user = User.find(session[:user_id])    
	end   
end

#---------- SIGN IN -------------

get '/' do
	puts "Loading up the home page and sign in"
	erb :home
end

get "/sign-in" do
	erb :home
end

post '/sign-in' do     
	puts "my params are" + params.inspect
	@user = User.where(username: params[:username]).first
	if @user && (@user.password == params[:password])
		session[:user_id] = @user.id
		erb :post
	else
		flash[:alert] = "Please try again."   
		redirect '/'
	end  
end

#------------- SIGN UP --------------

get '/signup' do
	erb :signup
end

post '/submit_user' do
	puts params.inspect
	user_info = params[:user]
	@user = User.create(user_info)
	if @user
		session[:user_id] = @user.id
	end
	erb :post
end

#------------- SIGN OUT --------------

get '/sign-out' do
	session[:user_id] = nil
	erb :home
end

#-------------- POST ----------------

get '/post' do
	@user = current_user
	erb :post
end

post '/submit_post' do
	puts "my params are" + params.inspect
	info = params[:post]
	if params[:post][:title] && params[:post][:post]
		Post.create(info)
		redirect '/profile'
	else
		flash[:alert] = "Please try again."   
		redirect '/post'
	end
end

#-------------PROFILE -----------------

get '/profile' do
	@user = current_user
	params.inspect
	@posts = Post.all
	@current = @user.posts
	@friends = @user.friends
	erb :profile
end

#------------ DELETE ---------------

get '/delete' do
	@user = current_user
	@user.destroy
	erb :home
end

#------------ USER LIST -----------

get '/userlist' do
	@user = current_user
	@users = User.all

	puts @user.friends.inspect
	erb :userlist
end

get '/friend/' do
	@user = current_user
	puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
	puts params[:friend_id]
	@user.friends << User.find(params[:friend_id])

	puts @user.friends.inspect

	puts "^^^^^^^^^^^^^^^^^^^^HHH^^^^^^^^^^"

	puts @user.friendships.inspect
	flash[:notice] = "You've add a new friend."
	redirect '/userlist'

end

#------------- FEED ---------------

get '/feed' do
	@posts = Post.all
	erb :feed
end


