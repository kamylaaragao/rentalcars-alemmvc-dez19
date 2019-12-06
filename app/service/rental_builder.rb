class RentalBuilder
  attr_reader :params, :subsidiary, :generator

  def initialize(params, subsidiary, token_generator = TokenGenerator)
    @params = params
    @subsidiary = subsidiary
    @generator = token_generator
  end

  def build
    @rental = Rental.new(params)
    @rental.subsidiary = subsidiary
    @rental.status = :scheduled
    @rental.reservation_code = generator.generate
    @rental
  end
end
