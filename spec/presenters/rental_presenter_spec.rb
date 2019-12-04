require 'rails_helper'

describe RentalPresenter do
  describe '#status_badge' do
    it 'should render primary badge' do
      rental = build(:rental, status: :scheduled)
      result = RentalPresenter.new(rental, nil).status_badge
      expect(result).to eq('<span class="badge badge-primary">agendada</span>')
    end
  end

  describe '#current_action' do
    include Rails.application.routes.url_helpers
    context 'authenticated user' do
      it 'should return start rental' do
        user = create(:user, role: :admin)
        subsidiary = create(:subsidiary, name: 'Almeida Motors')
        category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                          third_party_insurance: 20)
        car_model = create(:car_model, name: 'Sedan',
                           category: category)
        create(:car, car_model: car_model, license_plate: 'MVM-8383',
               subsidiary: subsidiary)
        rental = create(:rental, status: :scheduled, 
                        category: category, 
                        subsidiary: subsidiary,
                        start_date: 1.day.from_now, end_date: 10.days.from_now )

        result = RentalPresenter.new(rental, user).current_action

        expect(result).to eq("<a href=\"#{review_rental_path(rental)}\">Iniciar Locação</a>")
      end

      it 'should return continue rental' do
        user = create(:user, role: :admin)
        subsidiary = create(:subsidiary, name: 'Almeida Motors')
        category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                          third_party_insurance: 20)
        car_model = create(:car_model, name: 'Sedan',
                           category: category)
        create(:car, car_model: car_model, license_plate: 'MVM-8383',
               subsidiary: subsidiary)
        rental = create(:rental, status: :in_review, 
                        category: category, 
                        subsidiary: subsidiary,
                        start_date: 1.day.from_now, end_date: 10.days.from_now )

        result = RentalPresenter.new(rental, user).current_action

        expect(result).to eq("<a href=\"#{review_rental_path(rental)}\">Continuar Locação</a>")
      end

      it 'should return finish rental' do
        user = create(:user, role: :admin)
        subsidiary = create(:subsidiary, name: 'Almeida Motors')
        category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                          third_party_insurance: 20)
        car_model = create(:car_model, name: 'Sedan',
                           category: category)
        create(:car, car_model: car_model, license_plate: 'MVM-8383',
               subsidiary: subsidiary)
        rental = create(:rental, status: :ongoing,
                        category: category,
                        subsidiary: subsidiary,
                        start_date: 1.day.from_now, end_date: 10.days.from_now )

        result = RentalPresenter.new(rental, user).current_action

        expect(result).to eq("<a href=\"#{closure_review_rental_path(rental)}\">Encerrar Locação</a>")
      end

      it 'should return report rental to admins' do
        user = create(:user, role: :admin)

        subsidiary = create(:subsidiary, name: 'Almeida Motors')
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

        result = RentalPresenter.new(rental, user).current_action

        expect(result).to eq("<a href=\"#{report_rental_path(rental)}\">Reportar Problema</a>")
      end



      it 'should not return report rental to regular users' do
        user = create(:user)

        subsidiary = create(:subsidiary, name: 'Almeida Motors')
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

        result = RentalPresenter.new(rental, user).current_action

        expect(result).to eq('')
      end
    end

    context 'visitors' do
      it 'should not view start rental link' do
        subsidiary = create(:subsidiary, name: 'Almeida Motors')
        category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                          third_party_insurance: 20)
        car_model = create(:car_model, name: 'Sedan',
                           category: category)
        create(:car, car_model: car_model, license_plate: 'MVM-8383',
               subsidiary: subsidiary)
        rental = create(:rental, status: :scheduled, 
                        category: category, 
                        subsidiary: subsidiary,
                        start_date: 1.day.from_now, end_date: 10.days.from_now )

        user = nil
        result = RentalPresenter.new(rental, user).current_action

        expect(result).to eq("")
      end
    end

  end

end
