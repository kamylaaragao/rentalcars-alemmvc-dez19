class CarModelDecorator < Draper::Decorator
  delegate_all

  def car_options
    object.car_options.split(', ')
  end

end
