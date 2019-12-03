require 'rails_helper'

describe CarModelPresenter do
  describe '#car_options' do
    it 'should  return a html list' do
      car_model = build(:car_model, car_options: 'ar cond, teto solar, car play')
      decorated = car_model.decorate
      presenter_result = CarModelPresenter.new(decorated).car_options

      expect(presenter_result).to eq("<ul><li>ar cond</li><li>teto solar</li><li>car play</li></ul>")
    end
  end
end
