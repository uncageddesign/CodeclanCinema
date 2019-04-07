require_relative("../db/sql_runner")
require_relative('customer.rb')
require_relative('ticket.rb')
require_relative('screening.rb')


class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

#C
  def save()
  sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
  values = [@title, @price]
  films = SqlRunner.run(sql, values).first
  @id = films['id'].to_i
end

#R
  def self.all()
    sql = "SELECT * FROM films"
    results = SqlRunner.run(sql)
    return results.map { |film| Film.new(film) }
  end

#U
def update()
  sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
  values = [@title, @price]
  SqlRunner.run(sql, values)
end

#D
def delete()
  sql = "DELETE * FROM films WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.delete_all()
  sql = "DELETE * FROM films"
  SqlRunner.run(sql)
end

# Extensions
def attendees()
  sql =  "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE tickets.film_id = $1"
  values = [@id]
  results = SqlRunner.run(sql, values)
  return results.map { |attendee| Film.new(attendee) }
end

end
