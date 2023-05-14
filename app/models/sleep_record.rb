class SleepRecord < ApplicationRecord
  # relations
  belongs_to :user
  # callbacks
  before_save :calculate_duration, if: :check_time_start_and_end?

  private

  def calculate_duration
    self.duration = (clock_out - clock_in).to_i
  end

  def check_time_start_and_end?
    clock_in.present? && clock_out.present?
  end
end
