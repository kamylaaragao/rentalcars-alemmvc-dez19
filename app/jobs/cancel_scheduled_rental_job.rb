class CancelScheduledRentalJob
  attr_reader :limit_date

  def self.auto_enqueue(limit_date)
    Delayed::Job.enqueue(CancelScheduledRentalJob.new(limit_date))
  end

  def initialize(limit_date)
    @limit_date = limit_date
  end

  def perform
    Rental.scheduled.where('start_date > ?', limit_date).update_all(status: 20)
  end
end
