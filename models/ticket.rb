require_relative("../db/sql_runner")
require_relative('customer.rb')
require_relative('film.rb')
require_relative('screening.rb')

class Ticket

  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @screening_id = options['screening_id'].to_i
  end

#C
  def save()
    sql = "INSERT INTO tickets (customer_id, film_id, screening_id) VALUES ($1, $2, $3)
    RETURNING id"
    values = [@customer_id, @film_id, @screening_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

#R
  def self.all()
    sql = "SELECT * FROM tickets"
    results = SqlRunner.run(sql)
    return results.map { |ticket| Ticket.new(ticket) }
  end

#Update not required

#D
  def delete()
    sql = "DELETE * FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE * FROM tickets"
    SqlRunner.run(sql)
  end

end
