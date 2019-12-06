require 'rails_helper'

describe RentalBuilder do
  describe '.build' do
    it 'should build a rental instance' do
      client = create(:client)
      category = create(:category)
      subsidiary = create(:subsidiary)
      car_model = create(:car_model, name: 'sedan', category: category)
      car = create(:car, car_model: car_model, subsidiary: subsidiary)

      params = build(:rental, client: client, category: category,
                              start_date: Date.today,
                              end_date: Date.today + 1.days).attributes


      allow(TokenGenerator).to receive(:generate).and_return 'ABC123'

      result = described_class.new(params, subsidiary).build

      expect(result).to be_valid
      expect(result).to be_scheduled
      expect(result.subsidiary).to eq subsidiary

      expect(result.reservation_code).to eq 'ABC123'
    end

  end
end
