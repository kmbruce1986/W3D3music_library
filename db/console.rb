require('pry')

require_relative('../models/artists.rb')
require_relative('../models/albums.rb')

# As the Album requires an Artist in order to function (with the artist_id), the Albums should be deleted prior to the Artists being delted.
Album.delete_all()
Artist.delete_all()

artist1 = Artist.new(
  {
    'name' => "Kacey Musgraves"
  }
)

artist1.save()
# As the Album requires an artist in order to function, we must always create an artist prior to creating an album. 
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


album3 = Album.new(
  {
    'title' => "Golden Hour",
    'genre' => "Country & Western",
    'artist_id' => artist1.id
  }
)

album3.save

binding.pry
nil
