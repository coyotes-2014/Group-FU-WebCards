get '/' do
  if logged_in?
    @user = current_user
    erb :'user/index'
  else
    erb :index
  end
end

post '/sign_up' do
  if params[:password] == ""
    erb :'/error'
  else
    @user = User.new(name: params[:user_name], email: params[:email])
    @user.password = params[:password]
    @user.save!
    session[:logged_in] = true
    session[:user_id] = @user.id
    erb :"/user/#{@user.id}"
  end
end

post '/new_user' do
  erb :'/new_user'
end

post '/login' do
  @user = User.find_by(email: params[:email])
  if @user != nil
    if @user.password == params[:password]
      session[:logged_in] = true
      session[:user_id] = @user.id
      @decks = Deck.all
      @user_decks = Deck.where(user_id: @user.id)
      erb :"/user/#{@user.id}"
    else
      redirect '/'
    end
  else
    redirect '/'
  end
end

post '/sign_out' do
  session[:logged_in] = false
  session[:user_id] = 0
  redirect '/'
end
