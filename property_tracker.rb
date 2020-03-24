require('pg')
class PropertyTracker
  attr_accessor :address, :value, :bedrooms, :year_built
  attr_reader :id

  def initialize(options)
    @address = options['address']
    @value = options['value']
    @bedrooms = options['bedrooms']
    @year_built = options['year_built']
    @id = options['id'].to_i if options['id']
  end


  def save()
      db = PG.connect({dbname: 'properties', host:'localhost'})
      sql = "INSERT INTO property_info
            (address,
              value,
              bedrooms,
              year_built
            )
            VALUES
      (
        $1,
        $2,
        $3,
        $4
      )
      RETURNING *
      "

      values = [@address, @value, @bedrooms, @year_built]
      db.prepare("save", sql)
      @id = db.exec_prepared("save", values)[0]['id'].to_i
      db.close()
    end

  def PropertyTracker.all()
    db = PG.connect({dbname: 'properties', host:'localhost'})
    sql = "SELECT * FROM property_info"
    db.prepare("info", sql)
    home = db.exec_prepared("info")
    db.close()
    return home.map {|inquiry|PropertyTracker.new(inquiry)}
  end

  def update()
    db = PG.connect({dbname: 'properties', host:'localhost'})
    sql = "UPDATE property_info SET (
        address,
        value,
        bedrooms,
        year_built
      ) =
      ($1, $2, $3, $4)
      WHERE id = $5"
      values = [@address, @value, @bedrooms, @year_built, @id]
      dp.prepare("update", sql)
      dp.exec_prepared("update", values)
      db.close
  end


  def delete
    db = PG.connect({dbname: 'properties', host:'localhost'})
    sql = "DELETE FROM property_info WHERE id =$1"
    values =[@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

end
