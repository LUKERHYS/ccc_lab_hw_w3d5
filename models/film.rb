require_relative('../db/sql_runner')

class Film
  attr_reader :id
  attr_accessor :title, :price

  def initialize( options )
    @id = options['id'].to_i() if options['id']
    @title = options['title']
    @price = options['price']
  end

  ### INSTANCE_METHODS
  def save()
    sql = "INSERT INTO films (
    title, price
    ) VALUES (
      $1, $2
      ) RETURNING id"
      values = [@title, @price]
      films = SqlRunner.run(sql, values).first()
      @id = films['id'].to_i()
  end

  def update()
    sql = "UPDATE films SET (
    title, price
    ) = (
      $1, $2
      ) WHERE id = $3"
      values = [@title, @price, @id]
      SqlRunner.run(sql, values)
  end

  def customers()
  sql = "SELECT customers.* FROM customers
  INNER JOIN tickets ON tickets.customer_id = customers.id
  WHERE film_id = $1"
  values = [@id]
  customers = SqlRunner.run(sql, values)
  results = customers.map{|customer| Customer.new(customer)}
  return results
end

### CLASS_METHODS
def self.all()
  sql = "SELECT * FROM films"
  films = SqlRunner.run(sql)
  return films.map{|film| Film.new(film)}
end

def self.delete_all()
  sql = "DELETE FROM films"
  SqlRunner.run(sql)
end

def self.customer_count(film)
  return film.customers().count()
end

end
