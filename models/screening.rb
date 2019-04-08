require_relative("../db/sql_runner")
require_relative('customer.rb')
require_relative('film.rb')
require_relative('ticket.rb')

class Screening

  attr_reader :id
  attr_accessor :film_id, :screening

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @screening = options['screening']
  end

  def save()
    sql = "INSERT INTO screenings (film_id, screening) VALUES ($1, $2)
    RETURNING id"
    values = [@screening]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i
  end

end
