require_relative('../db/sql_runner')

class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize( options )
    @id = options['id'].to_i() if options['id']
    @name = options['name']
    @funds = options['funds'].to_i()
  end

### INSTANCE_METHODS
  def save()
    sql = "INSERT INTO customers (
    name, funds
    ) VALUES (
      $1, $2
      ) RETURNING id"
      values = [@name, @funds]
      customers = SqlRunner.run(sql, values).first()
      @id = customers['id'].to_i()
  end

  def update()
    sql = "UPDATE customers SET (
    name, funds
    ) = (
      $1, $2
      ) WHERE id =  $3"
      values = [@name, @funds, @id]
      SqlRunner.run(sql, values)
  end

  def films()
  sql = "SELECT films.* FROM films
  INNER JOIN tickets ON tickets.film_id = films.id
  WHERE customer_id = $1"
  values = [@id]
  films = SqlRunner.run(sql, values)
  results = films.map{|film| Film.new(film)}
  return results
end

### CLASS_METHODS
  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    return customers.map{|customer| Customer.new(customer)}
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end


  def self.cost_of_film(film)
    return film.price
  end

  def self.new_funds(film, customer)
    customer.funds -= cost_of_film(film)
    customer.update()
  end

  def self.ticket_count(customer)
    return customer.films().count()
  end

end
