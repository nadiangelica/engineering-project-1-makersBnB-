require 'user_repository'

def reset_user_table
  seed_sql = File.read('spec/seeds/test_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_user_table
  end

  it 'lists all the users' do
    repo = UserRepository.new
    expect(repo.all.length).to eq 7
    expect(repo.all[0].name).to eq('John')
  end

  it 'creates a new account for the user' do
    repo = UserRepository.new
    new_user = User.new
    new_user.name = 'Matt'
    new_user.email_address = 'matt@icloud.com'
    new_user.password = 'botswana'
    repo.create(new_user)
    expect(repo.all.length).to eq 8
    expect(repo.all.last.name).to eq 'Matt'
  end

  it 'creates a login access for the user' do
    repo = UserRepository.new
    login = repo.login('john7268@email.com','cat16$&')
    expect(login).to eq true
  end

  it 'creates a login access for the user' do
    repo = UserRepository.new
    login = repo.login('bryan@email.com','cat16$&')
    expect(login).to eq nil
  end
  it 'creates a login access for the user' do
    repo = UserRepository.new
    login = repo.login('john7268@email.com','dog87&')
    expect(login).to eq false
  end

it 'finds user by id' do
    repo = UserRepository.new
    user = repo.find(1)
    expect(user.name).to eq ('John')
    expect(user.email_address).to eq('john7268@email.com')
  end

  it 'finds user by email' do
    repo = UserRepository.new
    user = repo.find_by_email('john7268@email.com')
    expect(user.name).to eq('John')
    expect(user.id).to eq (1)
  end
end