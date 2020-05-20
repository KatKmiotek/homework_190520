require('pg')

class Property

attr_accessor :address, :value, :bedrooms, :year, :id

  def initialize(options)
    @id = options['id'] if options['id']
    @address = options['address']
    @value = options['value']
    @bedrooms = options['bedrooms']
    @year = options['year']
  end

def save()

  db = PG.connect({dbname: 'properties', host: 'localhost'})

  sql = "INSERT INTO properties(
  address, value, bedrooms, year
  ) VALUES ($1, $2, $3, $4)
  RETURNING id"

  values = [@address, @value, @bedrooms, @year]

  db.prepare("save", sql)

  pg_result = db.exec_prepared("save", values)

  @id = pg_result[0]["id"].to_i()

  db.close()

end

def Property.all()
  db = PG.connect({dbname: 'properties', host: 'localhost'})

  sql = "SELECT * FROM properties"
  db.prepare("all", sql)

  properties_db_result = db.exec_prepared("all")
  db.close

  properties = []
  for properties_hash in properties_db_result
    new_property = Property.new(properties_hash)
    properties.push(new_property)
  end
  return properties
end

def update()
  db = PG.connect({dbname: 'properties', host: 'localhost'})

  sql = "UPDATE properties SET (address, value, bedrooms, year) =
  ($1, $2, $3, $4) WHERE id = $5"

  values = [@address, @value, @bedrooms, @year, @id]

  db.prepare("update", sql)

  db.exec_prepared("update", values)
  db.close()
end

def delete()
  db = PG.connect({dbname: 'properties', host: 'localhost'})
  sql = "DELETE FROM properties WHERE id = $1"
  values = [@id]

  db.prepare("delete", sql)
  db.exec_prepared("delete", values)

  db. close()
end

def Property.delete_all()
  db = PG.connect({ dbname: 'properties', host: 'localhost'})
  sql = "DELETE FROM properties"

  db.prepare("delete_all", sql)
  db.exec_prepared("delete_all")

  db.close()
end

#find method that returns one instance of your class when an id is passed in
def Property.find_by_id()
db = PG.connect({ dbname: 'properties', host: 'localhost'})
sql = "SELECT * FROM properties WHERE id = $1"
value = [@id]

db.prepare("find_by_id", sql)
found_property = db.exec_prepared("find_by_id", value)
db.close()

return found_property

end

#find_by_address method that returns one instance of your class when a name is passed in, or nil if no instance is found

def Property.find_by_address()
  db = PG.connect({dbname: 'properties', host: 'localhost'})
  sql = "SELECT * FROM properties WHERE address = $1"
  value = [@address]

  db.prepare("find_by_address", sql)
  db. exec_prepared("find_by_address", value)

  db.close()


end



end
