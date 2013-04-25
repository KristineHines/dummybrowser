enable :sessions

get '/' do
  erb :index
end

get '/create' do
  erb :create
end

post '/create' do
  User.create(params)
  @message = "Login with your new account details"
  erb :index
end

post '/login' do
  if User.login(params)
    @user = User.find_by_email(params[:email])
    session[:id] = @user.id
    erb :secret_page
  else
    @message = "Error, either username or password incorrect"
    erb :index
  end
end

get '/logout' do
  session.clear
  erb :index
end

get '/secret' do
  if session[:id] 
    erb :secret_page
  else
    @message = "You must be logged in to see that page!"
    erb :index
  end
end
