class RentalByCategoryAndSubsidiaryQuery
  attr_reader :start_date, :end_date
  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def call
    sql = <<-SQL
      select s.name as subsidiary, c.name as category, count(*) as total
      from rentals r
      left join subsidiaries s on r.subsidiary_id = s.id
      left join categories c on r.category_id = c.id
      where start_date BETWEEN '#{start_date}' and '#{end_date}'
      group by s.id, c.id
      order by total DESC;
    SQL

    ActiveRecord::Base.connection.execute(sql)
  end
end
