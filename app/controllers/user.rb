post '/user/:id/deck/:deck_id' do
  if logged_in?
    @user = current_user
    session[:deck] = Deck.find_by(id: params[:deck_id])
    @deck = session[:deck]
    @user_deck = User_deck.new(user_id: @user.id, deck_id: @deck.id)
    erb :"/user/show_card"
  else
    erb :'/login'
  end
end

post '/user/:id/deck/:deck_id/done' do
  @user = current_user
  @deck = session[:deck]
  cards_left = @deck.cards.where(answered: false)
  result = (@user_deck.cards.size - cards_left)/@user_deck.cards.size
  User_deck.update(@user_deck.id, user_result: result)
  Card.update_all(answered: false)
  erb :"/user/results"
end

post '/user/:id/deck/:deck_id/guess' do
  @user = current_user
  @deck = session[:deck]
  @card = Card.find_by(id: params[:card_id])
  if params[:guess] == @card.definition
    Card.update(@card.id, answered: true)
    erb :"/user/deck/show_card"
  else
    erb :"/user/incorrect"
  end
end
