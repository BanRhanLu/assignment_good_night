class SleepRecord < ApplicationRecord
  # relations
  belongs_to :user
  # callbacks
  before_save :calculate_duration, if: :check_time_start_and_end?
  # scope

  private

  def calculate_duration
    self.duration = (wake_up - sleep).to_i
  end

  def check_time_start_and_end?
    sleep.present? && wake_up.present?
  end
end
