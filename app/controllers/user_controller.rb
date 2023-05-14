class UserController < ApplicationController
  def index; end

  def record
    record_params = params.permit(:id).to_h.with_indifferent_access
    user_id = record_params[:id]
    records = User.find(user_id).sleep_records.order('created_at desc')
    render(json: { success: true, error: nil, sleep_records: records })
  rescue StandardError => e
    render(json: { success: false, error: e.message })
  end

  def sleep
    sleep_params = params.permit(:id, :record_id, :sleep_time).to_h.with_indifferent_access
    user_id = sleep_params[:id]
    record_id = sleep_params[:record_id]
    time_at = trans_time_to_local(sleep_params[:sleep_time])
    if record_id.nil?
      User.find(user_id).sleep_records.create(sleep: time_at)
    else
      record = SleepRecord.find(record_id)
      raise 'Wake_up earier than sleep' if (time_at > record.wake_up) && record.wake_up.present?

      record.sleep = time_at
      record.save!
    end
    render(json: { success: true, error: nil })
  rescue StandardError => e
    render(json: { success: false, error: e.message })
  end

  def wake_up
    wake_up_params = params.permit(:id, :record_id, :wake_up_time).to_h.with_indifferent_access
    record_id = wake_up_params[:record_id]
    time_at = trans_time_to_local(wake_up_params[:wake_up_time])
    record = SleepRecord.find(record_id)
    raise 'Wake_up earier than sleep' if (record.sleep > time_at) && record.sleep.present?

    record.wake_up = time_at
    record.save!
    render(json: { success: true, error: nil })
  rescue StandardError => e
    render(json: { success: false, error: e.message })
  end

  def trans_time_to_local(time_param)
    time_at = Time.zone.parse(time_string) unless time_param.nil?
    time_at || Time.zone.now
  end
end
