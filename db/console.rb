require('pry')

require_relative('../models/artists.rb')
require_relative('../models/albums.rb')


artist1 = Artist.new(
  {
    'name' => "Kacey Musgraves"
  }
)

artist1.save()

album1 = Album.new(
  {
    'title' => "Pageant Material",
    'genre' => "Country & Western",
    'artist_id' => artist1.id
  }
)

album1.save()

artist2 = Artist.new(
  {
    'name' => "Ed Sheeran"
  }
)

artist2.save()

album2 = Album.new(
  {
    'title' => "x",
    'genre' => "Pop",
    'artist_id' => artist2.id
  }
)

album2.save

binding.pry
nil
