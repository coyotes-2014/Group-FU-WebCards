post '/user/:id/deck/:deck_id' do
  if logged_in?
    @user = current_user
    @deck = Deck.find_by(id: params[:deck_id])
    @user_deck = UserDeck.create(user_id: @user.id, deck_id: @deck.id, results: 0)
    session[:user_deck_id] = @user_deck.id
    cards = Card.where(deck_id: @deck.id, answered: false)
    @card = cards.sample
    erb :"/user/show_card"
  else
    erb :'/login'
  end
end

post '/user/:id/deck/:deck_id/done' do
  @user = current_user
  @deck = Deck.find_by(id: params[:deck_id])
  cards_left = @deck.cards.where(answered: false)
  @result = (@deck.cards.size.to_f - cards_left.size.to_f)/@deck.cards.size.to_f
  @result *= 100.0
  @user_deck = UserDeck.find_by(id: session[:user_deck_id])
  UserDeck.update(@user_deck.id, results: @result.to_f)
  Card.update_all(answered: false)
  erb :"/results"
end

post '/user/:id/deck/:deck_id/guess' do
  @user = current_user
  @deck = Deck.find_by(id: params[:deck_id])
  @card = Card.find_by(id: params[:card_id])
  @userdeck = UserDeck.find_by(id: session[:user_deck_id])
  @guess = @userdeck.total_guesses + 1
  UserDeck.update(@userdeck.id, total_guesses: @guess)
  if params[:guess] == @card.term
    Card.update(@card.id, answered: true)
    @userdeck = UserDeck.find_by(id: session[:user_deck_id])
    @correct = @userdeck.total_correct + 1
    UserDeck.update(@userdeck.id, total_correct: @correct)
    cards = Card.where(deck_id: @deck.id, answered: false)
    @card = cards.sample
    erb :"/user/show_card"
  else
    @user = current_user
    @userdeck = UserDeck.find_by(id: session[:user_deck_id])
    @incorrect = @userdeck.total_incorrect + 1
    UserDeck.update(@userdeck.id, total_incorrect: @incorrect)
    erb :"/user/incorrect"
  end
end

post '/user/:id/deck/:deck_id/skip' do
  @user = current_user
  @deck = Deck.find_by(id: params[:deck_id])
  cards = Card.where(deck_id: @deck.id, answered: false)
  @card = cards.sample
  erb :"/user/show_card"
end
