class SleepRecordController < ApplicationController
  def following_sleep_record
    record_params = params.permit(:user_id).to_h.with_indifferent_access
    user_id = record_params[:user_id]
    following_ids = User.find(user_id).follow_ships.pluck(:following_id)
    following_users = User.where(id: following_ids)
    records = output_factory(following_users)
    records = records.sort_by { |hash| hash[:sum_durations].to_i }
    render(json: { success: true, error: nil, data: records })
  rescue StandardError => e
    render(json: { success: false, error: e.message })
  end

  private

  def output_factory(following_users)
    following_users.includes(:sleep_records).map do |user|
      build_following_sleep_record_json(user)
    end
  end

  def build_following_sleep_record_json(user)
    user_json = user.as_json(only: %i[id name], root: false)
    summary = {}
    summary.merge!(
      user_json,
      build_user_json_record_config(user)
    )
    summary
  end

  def build_user_json_record_config(user)
    start_time = (Time.zone.now - 1.week).beginning_of_day
    end_time = (Time.zone.now - 1.day).end_of_day
    prev_week_sleep_records = user.sleep_records.select { |record| (record.sleep < end_time && record.sleep > start_time ) || ( record.wake_up < end_time && record.wake_up > start_time )}
    prev_week_sleep_records_with_durations = prev_week_sleep_records.reject { |record| record.duration.nil? }
    {
      sleep_records: prev_week_sleep_records,
      sum_durations: prev_week_sleep_records_with_durations.sum{ |record| record.duration }
    }
  end
end
