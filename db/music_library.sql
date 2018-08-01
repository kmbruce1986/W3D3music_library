-- drop the albums first as we cannot delete an artist if there is an album still attached. 
DROP TABLE IF EXISTS albums;
DROP TABLE IF EXISTS artists;
-- the artists table should come before the albums as an artist is required in order to create an album
CREATE TABLE artists (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE albums (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  genre VARCHAR(255),
  artist_id INT REFERENCES artists(id)
);
