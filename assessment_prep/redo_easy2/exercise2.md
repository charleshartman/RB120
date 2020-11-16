
# Fix the Program - Drivable

Correct the following program so it will work properly. Assume that the Car class has a complete implementation; just make the smallest possible change to ensure that cars have access to the drive method.

```ruby
module Drivable
  def drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive
```

The method defined in the `Drive` module is a class method, but on `line 17` we are attempting to call an instance method. A class method is can only be invoked by the class, so as it is, the only way to access this method is with `Drivable.drive`. To call `#drive` on the `bobs_car` object, we need to define `drive` in the `Drivaable` module as an instance method. Thus the fix is as simple as eliminating the `self` in method definition on `line 8`.
