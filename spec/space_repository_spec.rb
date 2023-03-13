require 'space_repository'

describe SpaceRepository do
    def reset_spaces_table
        seed_sql = File.read('spec/seeds/test_seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
        connection.exec(seed_sql)
    end

    before(:each) do
        reset_spaces_table
    end

    it 'lists all spaces' do
        repo = SpaceRepository.new
        spaces = repo.all
        expect(spaces.length).to eq 2
        expect(spaces.first.name).to eq 'Camden Flat'
        expect(spaces.last.price_per_night).to eq 119.00
    end

    it 'finds space by id' do
        repo = SpaceRepository.new
        space = repo.find(2)
        expect(space.name).to eq 'St Ives Cottage'
    end

    it 'adds new space' do
        space = Space.new
        space.name = 'Windmill Tower'
        space.description = 'Spectacular views of the Yorkshire countryside'
        space.price_per_night = 99.00
        repo = SpaceRepository.new
        repo.create(space)
        expect(repo.all.length).to eq 3
        expect(repo.all.last.name).to eq 'Windmill Tower'
    end

    it 'finds space by date range' do
        repo = SpaceRepository.new
        spaces = repo.find_by_date('2023-05-01', '2023-05-31')
        expect(spaces.first.name).to eq 'Camden Flat'
    end
end