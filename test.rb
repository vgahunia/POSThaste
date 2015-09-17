

if current_user
		@user = current_user
		erb :index
	else
		redirect "/sign-in"
	end

	<% @users.each do |user| %>
	<h2>
		<%= user.username %>
	</h2>
	<br>
	<% end %>

	<% @posts.each do |post| %>
	<h2>
		<%= post.title %>
	</h2>
	<br>
	<% end %>

get '/sign-out' do
	session[:user_id] = nil
	erb :sign_in
end