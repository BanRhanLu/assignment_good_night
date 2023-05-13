class UserController < ApplicationController
  def index; end

  def record
    begin
      record_params = params.permit(:id).to_h.with_indifferent_access
      user_id = record_params[:id]
      records = User.find(user_id).sleep_records.order('created_at desc')
      render(json: { success: true, error_message: nil, sleep_records: records })
    rescue => e
      render(json: { error: e.message })
    end
  end

 
end
