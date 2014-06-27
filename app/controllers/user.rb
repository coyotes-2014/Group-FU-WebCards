post '/user/:id/deck/:deck_id' do
  if logged_in?
    @user = current_user
    @deck = Deck.find_by(id: params[:deck_id])
    @user_deck = User_deck.new(user_id: @user.id, deck_id: @deck.id)
    erb :"/user/show_card"
  else
    erb :'/login'
  end
end

post '/user/:id/deck/:deck_id/done' do
  @user = current_user
  @deck = User_deck.find_by(id: params[:deck_id])
  cards_left = @user_deck.where(cards.answered: false)
  result = (@user_deck.cards.size - cards_left)/@user_deck.cards.size
  User_deck.update(@user_deck.id, user_result: result)
  erb :"/user/index"
end

post '/user/:id/deck/:deck_id/guess' do
  @user = current_user
  @deck = User_deck.find_by(id: params[:user_deck_id])
  @card = Card.find_by(id: params[:card_id])
  if params[:guess] == @card.definition
    Card.update(@card.id, answered: true)
    erb :"/user/#{@user.id}/deck/#{@deck.id}/show_card"
  else
    erb :"/user/show_card/incorrect"
  end
end

# post '/user/:id/deck/:deck_id/results' do
#   @user = current_user
#   @deck = User_deck.find_by(id: params[:deck_id])
#   cards_left = @user_deck.where(cards.answered: false)
#   result = (@user_deck.cards.size - cards_left)/@user_deck.cards.size
#   User_deck.update(@user_deck.id, user_result: result)
#   erb :"/user/#{@user.id}"
# end
