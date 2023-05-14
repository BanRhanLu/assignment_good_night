class SleepRecord < ApplicationRecord
  # relations
  belongs_to :user
  # callbacks
  before_save :calculate_duration, if: :check_time_start_and_end?
  # scope
  scope :search_by_date,
  (lambda do |sdate, edate|
     sdate_time = sdate.beginning_of_day
     edate_time = edate.end_of_day
     where(
       '(clock_in between ? and ?) OR (clock_out between ? and ?)',
       sdate_time,
       edate_time,
       sdate_time,
       edate_time,
     )
   end
  )

  private

  def calculate_duration
    self.duration = (clock_out - clock_in).to_i
  end

  def check_time_start_and_end?
    clock_in.present? && clock_out.present?
  end
end
