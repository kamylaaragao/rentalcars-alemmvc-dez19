require 'rails_helper'

describe RentalActionsAuthorizer do
  describe '.authorized?' do
    it 'should authorize admins' do
      subsidiary = create(:subsidiary, name: 'Vila Mariana')
      user = create(:user, role: :admin, subsidiary: subsidiary)

      category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                        third_party_insurance: 20)
      car_model = create(:car_model, name: 'Sedan',
                         category: category)
      create(:car, car_model: car_model, license_plate: 'MVM-8383',
             subsidiary: subsidiary)
      rental = create(:rental, status: :finalized,
                      category: category,
                      subsidiary: subsidiary,
                      start_date: 1.day.from_now, end_date: 10.days.from_now )

      expect(described_class.new(rental, user)).to be_authorized
    end

    it 'should authorize same subsidiary users' do

    end
 
    it 'should not authorize other subsidiary users' do
    end
  end
end
