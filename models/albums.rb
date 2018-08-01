require('pg')
require_relative('../db/sql_runner.rb')

class Album
# always remember to include the accessor for updating and deleting!
  attr_reader :id, :artist_id
  attr_accessor :title, :genre

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save
    sql = "INSERT INTO albums (title, genre, artist_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@title, @genre, @artist_id]
    # below, we are passing what is returned (the id) into an array, therefore we save it to a variable called results.  We then return this at the end of the function
    results = SqlRunner.run(sql, values)
    # below, we are returning the first instance within the array [0] and then we need to get just the 'id' and we turn it into an integer
    @id = results[0]["id"].to_i()
  end

  def self.all
    sql = "SELECT * FROM albums"
    results = SqlRunner.run(sql)
    # as this will return several albums in an array, we should map this, create a new instance of the Album class and then feed each album into it.
    return results.map {|album| Album.new(album)}
  end

  def artist
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    results = SqlRunner.run(sql, values)
    # there will only be one artist to each album, so there is no need to map the array
    return Artist.new(results[0])
  end

  def update
    sql = "UPDATE albums SET (title, genre, artist_id) = ($1, $2, $3) WHERE id = $4"
    values = [@title, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.find
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    album_hash = results.first
    album = Album.new(album_hash)
    return album
  end

end
