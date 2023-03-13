require 'sinatra/base'
require 'sinatra/reloader'
require './lib/database_connection'
require './controllers/list_spaces_controller'
require './controllers/add_spaces_controller'

DatabaseConnection.connect('makersbnb_test')

class MakersBnB < Sinatra::Base
    configure :development do
        register Sinatra::Reloader
        set :public_folder, 'public'
        set :views, 'views'
        use ListSpaces
        use AddSpaces
    end
end



