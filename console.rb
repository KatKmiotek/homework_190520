require('pry')
require_relative('models/property')

property1 = Property.new({
  'address' => '123 Fake Street',
  'value' => 250000,
  'bedrooms' => 2,
  'year' => 1950
    })

property2 = Property.new({
  'address' => '567 Liar Close',
  'value' => 10000,
  'bedrooms' => 1,
  'year' => 1977
    })


property1.save()
property2.save()

binding.pry



delete_all_properties = Property.delete_all
all_properties = Property.all()

binding.pry

nil
