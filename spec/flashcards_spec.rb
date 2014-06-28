require 'spec_helper'

require 'spec_helper'

describe 'flashcards' do
  let! (:user) {User.new(name: "tester", password: "")}

  it 'renders successully' do
    session[:logged_in] = true
    session[:user_id] = user.id
    get "/"
    expect(last_response).to be_ok
  end

end

describe 'logs in' do
  let! (:user) {User.create(name: "tester", email: "adf", password: "bob")}
  it 'logs_in' do
    session[:logged_in] = true
    session[:user_id] = user.id
    post '/login', {email: "adf", password: "bob"}
    expect(last_response).to be_ok
  end
  after(:each) { User.delete_all }
end

describe 'allows a user to sign_up' do
  it 'allows a user to sign_up' do
    get '/sign_up'
    expect(last_response).to be_ok
  end
end

describe 'creates a new user' do
  it 'creates a new user' do
    post '/sign_up', {:user_name => "testing", :email => "asdgasdg"}
    expect(last_response).to be_ok
  end
  after(:each) { User.delete_all }
end

