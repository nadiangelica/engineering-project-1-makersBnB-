require_relative 'space'

class SpaceRepository
    def self.instance
        @instance ||= self.new
    end
    def all
        sql = 'SELECT id, name, description, price_per_night, available_from, available_to, host_id FROM spaces;'
        result_set = DatabaseConnection.exec_params(sql, [])
        spaces = []
        result_set.each do |record|
            space = Space.new
            space.id = record['id'].to_i
            space.name = record['name']
            space.description = record['description']
            space.available_from = record['available_from']
            space.available_to = record['available_to']
            space.host_id = record['host_id']
            space.price_per_night = record['price_per_night'].gsub("$","").to_f
            spaces << space
        end
        
        return spaces
    end

    def find(id)
        sql = 'SELECT name, description, price_per_night, available_from, available_to, host_id FROM spaces WHERE id = $1;'
        record = DatabaseConnection.exec_params(sql, [id]).first
        space = Space.new
        space.name = record['name']
        space.description = record['description']
        space.price_per_night = record['price_per_night'].gsub("$","").to_f
        space.available_from = record['available_from']
        space.available_to = record['available_to']
        space.host_id = record['host_id']
        return space
    end

    def create(space)
        sql = 'INSERT INTO spaces (name, description, price_per_night, available_from, available_to, host_id) VALUES ($1, $2, $3, $4, $5, $6);'
        params = [space.name, space.description, space.price_per_night, space.available_from, space.available_to, space.host_id]
        DatabaseConnection.exec_params(sql, params)
        return space
    end

    def find_by_date(book_from, book_to)
        sql = "SELECT id, name, description, price_per_night, host_id 
            FROM spaces 
            WHERE available_from <= TO_DATE($1, 'YYYY-MM-DD')
            AND available_to >= TO_DATE($2, 'YYYY-MM-DD');"
        params = [book_from, book_to]
        result_set = DatabaseConnection.exec_params(sql, params)
        spaces = []
        result_set.each do |record|
            space = Space.new
            space.id = record['id'].to_i
            space.name = record['name']
            space.description = record['description']
            space.host_id = record['host_id']
            space.price_per_night = record['price_per_night'].gsub("$","").to_f
            spaces << space
        end

        return spaces
    end
end