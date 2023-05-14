class SleepRecordController < ApplicationController
  def following_sleep_record
    record_params = params.permit(:user_id).to_h.with_indifferent_access
    user_id = record_params[:user_id]
    following_ids = User.find(user_id).follow_ships.pluck(:following_id)
    following_users = User.joins(:sleep_records)
                          .where(id: following_ids)
                          .select('users.*, SUM(sleep_records.duration) AS total_durations')
                          .group('users.id')
                          .order('total_durations DESC')
    records = output_factory(following_users)
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
    start_time = Time.zone.now - 1.week
    end_time = Time.zone.now - 1.day
    prev_week_sleep_records = user.sleep_records.search_by_date(start_time, end_time).order('created_at desc')
    {
      sleep_records: prev_week_sleep_records,
      sum_durations: user.total_durations
    }
  end
end
