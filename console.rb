require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')
require_relative('models/screening.rb')


require('pry-byebug')

#Customer.delete_all()

customer1 = Customer.new({
  'name' => 'Mhairi McCrindle',
  'funds' => '50'
  })
customer1.save()

customer2 = Customer.new({
  'name' => 'Ali Gibson',
  'funds' => '60'
  })
customer2.save()

film1 = Film.new({
  'title' => 'Captain Marvel',
  'price' => '10'
  })
film1.save()

film2 = Film.new({
  'title' => 'Us',
  'price' => '10'
  })
film2.save()

tickets1 = Ticket.new({
  'customer_id' => '1',
  'film_id' => '1',
  'showing_id' => '2'
  })
tickets1.save()

tickets2 = Ticket.new({
  'customer_id' => '2',
  'film_id' => '1',
  'showing_id' => '2'
  })
tickets2.save()

tickets3 = Ticket.new({
  'customer_id' => '1',
  'film_id' => '2',
  'showing_id' => '1'
  })
tickets3.save()

screening1 = Showing.new({
  'film_id' => '1',
  'showing' => '13:20'
  })
screening1.save()

screening2 = Showing.new({
  'film_id' => '1',
  'showing' => '18:00'
  })
screening2.save()

screening3 = Showing.new({
  'film_id' => '2',
  'showing' => '12:00'
  })
screening3.save()


binding.pry

nil
