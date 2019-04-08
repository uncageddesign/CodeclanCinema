require_relative("../db/sql_runner.rb")
require_relative('film.rb')
require_relative('ticket.rb')
require_relative('screening.rb')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

#C
  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING ID"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

#R
  def Customer.all()
    sql = "SELECT * FROM customers"
    results = SqlRunner.run(sql)
    return results.map { |customer| Customer.new(customer) }
  end

#U
  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds]
    SqlRunner.run(sql, values)
  end

#D
  def delete()
    sql = "DELETE * FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE * FROM customers"
    SqlRunner.run(sql)
  end

# Extensions
  def tickets_bought()
    sql = "SELECT * FROM tickets WHERE customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |tickets| Ticket.new(tickets) }
  end

  def buy_ticket()
    # call on the db to get the customers funds
    sql = "SELECT customers.funds FROM customers WHERE funds = $1"
    values = [@funds]
    results = SqlRunner.run(sql, values)
    # subtract the price of the ticket from the customers funds
    purchase = results.to_i -= 10
    # Update the db with the new amount
    return self.update(purchase)
  end

end
