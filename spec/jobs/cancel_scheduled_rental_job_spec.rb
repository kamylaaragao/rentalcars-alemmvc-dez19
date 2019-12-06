require 'rails_helper'

describe CancelScheduledRentalJob do
  describe '.perform' do
    it '.auto_enqueue' do
      described_class.auto_enqueue(Date.current)
      expect(Delayed::Worker.new.work_off).to eq [1, 0]
    end

    it 'should canceld past rentals' do
      subsidiary = create(:subsidiary, name: 'Paulista')
      category = create(:category)
      create_list(:car, 5, category: category, subsidiary: subsidiary)

      old_rental = create(:rental, category: category, subsidiary: subsidiary,
                  start_date: 10.days.ago, end_date: 2.days.ago)

      future_rental = create(:rental, category: category, subsidiary: subsidiary,
                  start_date: 1.day.from_now, end_date: 2.days.from_now)

      CancelScheduledRentalJob.auto_enqueue(Time.current)
      Delayed::Worker.new.work_off
      future_rental.reload
      old_rental.reload

      expect(future_rental).to be_canceled
      expect(old_rental).to be_scheduled
    end
  end
end
