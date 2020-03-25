require('pry-byebug')

require_relative('property_tracker')

# @address = options['address']
# @value = options['value']
# @bedrooms = options['bedrooms']
# @year_built = options['year_built']
house1 = PropertyTracker.new({'address'=> 'Springfield',
                              'value'=> 200,
                              'bedrooms'=> 5,
                              'year_built'=>1989
                              })
house2 = PropertyTracker.new({'address'=> 'Southpark',
                              'value'=> 150,
                              'bedrooms'=> 4,
                              'year_built'=>1997
                              })


house1.save()
house2.save()

house2.address = "Glasgow"
house2.update()

home = PropertyTracker.all()
house1.delete()

binding.pry
nil
