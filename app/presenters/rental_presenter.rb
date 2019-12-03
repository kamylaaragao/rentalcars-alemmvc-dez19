class RentalPresenter < SimpleDelegator
  attr_reader :rental

  def initialize(rental)
    super(rental)
  end

  def status
    if scheduled?
      helper.content_tag :span, class: 'badge badge-primary' do
        'agendada'
      end
    elsif finalized?
      helper.content_tag :span, class: 'badge badge-success' do
        'finalizada'
      end
    end
  end

  private

  def helper
    ApplicationController.helpers
  end
end
