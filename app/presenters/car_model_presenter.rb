class CarModelPresenter < SimpleDelegator
  delegate :concat, to: :h
  def initialize(car_model)
    super(car_model)
  end

  def car_options
    h.content_tag(:ul) do
      __getobj__.car_options.each do |item|
        concat(h.content_tag(:li, item))
      end
    end
  end

  private

  def h
    ApplicationController.helpers
  end
end
