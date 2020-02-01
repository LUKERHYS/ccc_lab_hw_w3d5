require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

require('pry')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

customer1 = Customer.new({'name' => 'Luke', 'funds' => '85'})
customer1.save()
customer2 = Customer.new({'name' => 'Lyndsey', 'funds' => '50'})
customer2.save()
customer3 = Customer.new({'name' => 'Adam', 'funds' => '60'})
customer3.save()
customer4 = Customer.new({'name' => 'Hollie', 'funds' => '75'})
customer4.save()

film1 = Film.new({'title' => 'Titanic', 'price' => 5})
film1.save()
film2 = Film.new({'title' => 'Lion King', 'price' => 8})
film2.save()
film3 = Film.new({'title' => 'The Aristocats', 'price' => 7})
film3.save()
film4 = Film.new({'title' => 'Dumbo', 'price' => 10})
film4.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()
ticket2 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket2.save()
ticket3 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film3.id})
ticket3.save()
ticket4 = Ticket.new({'customer_id' => customer4.id, 'film_id' => film4.id})
ticket4.save()
ticket5 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film1.id})
ticket5.save()


binding.pry
nil
