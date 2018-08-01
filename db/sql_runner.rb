require('pg')
# no other files are required.

class SqlRunner

  def self.run(sql, values = [])

    begin
      db = PG.connect({dbname: "music_library", host: "localhost"})
      db.prepare("query", sql)
      result = db.exec_prepared("query", values)
    ensure
      # this closes the db
      db.close() if db != nil
    end
    return result

  end

end
