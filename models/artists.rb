require('pg')
require_relative('../db/sql_runner.rb')
# sql runner required only

class Artist
# remember that the id should never be allowed to be edited.
  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @name = options['name']

  end

  def save
    sql = "INSERT INTO artists name VALUES $1 RETURNING id"
    values = [@name]
    # below, we are passing what is returned (the id) into an array, therefore we save it to a variable called results.  We then return this at the end of the function
    results = SqlRunner.run(sql, values)
    # below, we are returning the first instance within the array [0] and then we need to get just the 'id' and we turn it into an integer
    @id = results[0]["id"].to_i()
  end

  def self.all
    sql = "SELECT * FROM artists"
    results = SqlRunner.run(sql)
    # as this will return several artists in an array, we should map this, create a new instance of the Artist class and then feed each artist into it.
    return results.map {|artist| Artist.new(artist)}
  end

  def album
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    # you need to map this in case there is more than one album by an artist
    return results.map { |album| Album.new(album)}
  end

  def update
    sql = "UPDATE artists SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
    # nothing is being returned, but we are feeding it two values.
  end

  def delete
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
    # nothing is being returned, but we are feeding it a value.
  end

  def self.delete_all
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
    # nothing is being returned.
  end

  def self.find
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    artist_hash = results.first
    artist = Artist.new(artist_hash)
    return artist
    # we feed this a value, we get a hash back.  
  end

end
