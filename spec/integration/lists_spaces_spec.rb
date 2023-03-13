require "spec_helper"
require "rack/test"
require './controllers/list_spaces_controller'
require 'json'

describe ListSpaces do
  include Rack::Test::Methods

  def reset_spaces_table
    seed_sql = File.read('spec/seeds/test_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
      reset_spaces_table
  end

  let(:app) { ListSpaces.new }

  context 'GET /listings' do
    it 'should show all the listings' do
      response = get('/listings')
      expect(response.status).to eq(200)
      expect(response.body).to include('St Ives Cottage')
      expect(response.body).to include('Camden Flat')    
    end
  end

  context 'POST /listings' do
    it 'should select a range of dates' do
      response = post('/listings', 
        trip_start: '2023-05-01', 
        trip_end: '2023-05-31'
      )
      expect(response.status).to eq 200
         
      expect(response.body).to include('Camden Flat')
      expect(response.body).not_to include('St Ives Cottage')
    end
  end
end
