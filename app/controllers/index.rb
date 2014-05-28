enable :sessions

get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/user/new' do
  erb :new_user
end

post '/user/new' do
  p params

  @user = User.create( username: params[:username], 
                              email: params[:email], 
                              password: params[:password] )

  session[:user_id] = @user.id

  redirect "/user/#{@user.username}"
end

get '/login' do
  erb :login
end

post '/login' do
  user = User.authenticate(email: params[:email], password: params[:password])

  if user
    session[:user_id] = user.id
    redirect to "/user/#{user.username}"
  else
  	#####IMPLEMENT: LOGIN ERROR MESSAGE.
    redirect to '/login'
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/user/:username' do
  user = User.find_by_username(params[:username])
  @user_id = user.id if user

  
  if @user_id
    erb :profile
  else 
  	#####IMPLEMENT: NO USER FOUND
  	redirect '/'
  end

end
