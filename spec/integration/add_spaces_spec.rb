require "spec_helper"
require "rack/test"
require './controllers/add_spaces_controller'
require './controllers/list_spaces_controller'
require 'json'

describe AddSpaces do
  include Rack::Test::Methods

  def reset_spaces_table
    seed_sql = File.read('spec/seeds/test_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
      reset_spaces_table
  end
  let(:app) { AddSpaces.new }

  context 'GET /add_listing' do
    it 'shows form to add listing' do
      response = get('/add_listing')
      expect(response.status).to eq(200)
      expect(response.body).to include('<form action=')
      expect(response.body).to include('name="description">')
      expect(response.body).to include('<input id="submit" type="submit" value="Submit the form">')
      expect(response.body).to include('"price_per_night">')
    end
  end

  context 'POST /add_listing' do
    it 'returns 200 OK when it creates a new listing' do
      response = post('/add_listing', 
        name: 'Sunny Vila in Madrid', 
        description: 'Beautiful place for a holiday.', 
        price_per_night: 150.00,
        available_from: '2023-01-18',
        available_to: '2023-10-31',
        host_email: 'amanda7680@email.com'
      )
      expect(response.status).to eq(200)
      response = get('/listings/3')
      expect(response.status).to eq(200)
      expect(response.body).to include('Sunny Vila in Madrid')
    end
  end

  context 'GET listings/ :id' do
    it 'get space 1' do
      result = get('/listings/1')
      expect(result.status).to eq (200)
      expect(result.body).to include('Camden Flat')
    end
  end
end
