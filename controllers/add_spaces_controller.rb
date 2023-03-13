require 'sinatra/base'
require 'sinatra/reloader'
require './lib/space_repository'
require './lib/user_repository'

class AddSpaces < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    set :public_folder, 'public'
    set :views, 'views'
    also_reload 'lib/space_repository.rb'
  end

  before do
    @space_repo = SpaceRepository.instance
  end

    get '/add_listing' do
        return erb(:add_listing)
    end

    get '/listings/:id' do
        space = @space_repo.find(params[:id]) 
        @name = space.name
        @description = space.description
        @price_per_night = space.price_per_night
        @available_from = space.available_from
        @available_to = space.available_to
        @host_id = space.host_id
        @host_email = UserRepository.new.find(space.host_id).email_address
        return erb(:listing)
    end

   post '/add_listing' do
      # Taking form params and assigning them to a new instance of a space
      new_listing = Space.new
      new_listing.name = params[:name]
      new_listing.description = params[:description]
      new_listing.price_per_night = params[:price_per_night]
      new_listing.available_from = params[:available_from]
      new_listing.available_to = params[:available_to]
      new_listing.host_id = UserRepository.new.find_by_email(params[:host_email]).id
      @space_repo.create(new_listing)
      # After being added to the repo re-assigning erb dynamic variables to reflect new listing
      @user_id = @space_repo.all.last.id
      @name = @space_repo.all.last.name
      @description = @space_repo.all.last.description
      @price_per_night = @space_repo.all.last.price_per_night
      @available_from = @space_repo.all.last.available_from
      @available_to = @space_repo.all.last.available_to
      @host_email = params[:host_email]
      
      return erb(:listing)
    end
end