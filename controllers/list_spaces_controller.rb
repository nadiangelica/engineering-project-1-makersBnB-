require 'sinatra/base'
require 'sinatra/reloader'
require './lib/space_repository'
class ListSpaces < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    set :public_folder, 'public'
    set :views, 'views'
    also_reload 'lib/space_repository.rb'
  end

  before do
    @space_repo = SpaceRepository.instance
  end
  
  get '/listings' do
    @spaces = @space_repo.all
    # today = Time.now
    # tomorrow = today + (24 * 60 * 60)
    # @default_from_date = today.strftime("%Y-%m-%d)")
    # @default_to_date = tomorrow.strftime("%Y-%m-%d)")
    @filtered = false

    return erb(:listings)
  end

  post '/listings' do
    @trip_start = params[:trip_start]
    @trip_end =  params[:trip_end]
    
    @spaces = @space_repo.find_by_date(@trip_start,@trip_end)
    @filtered = true
    
    return erb(:listings)
  end
end