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
    sleep_params = params.permit(:id).to_h.with_indifferent_access
    user_id = sleep_params[:id]
    User.find(user_id).sleep_records.create(sleep: Time.zone.now)
    render(json: { success: true, error: nil })
  rescue StandardError => e
    render(json: { success: false, error: e.message })
  end

  def wake_up
    wake_up_params = params.permit(:id, :record_id).to_h.with_indifferent_access
    record_id = wake_up_params[:record_id]
    record = SleepRecord.find(record_id)
    record.wake_up = Time.zone.now
    record.save!
    render(json: { success: true, error: nil })
  rescue StandardError => e
    render(json: { success: false, error: e.message })
  end
end
