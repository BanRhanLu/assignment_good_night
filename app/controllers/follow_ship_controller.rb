class FollowShipController < ApplicationController
  def show
    user = User.find(params.permit(:user_id).to_h.with_indifferent_access[:user_id])
    render(json: { success: true, error: nil, data: user.follow_ships })
  rescue StandardError => e
    render(json: { success: false, error: e.message })
  end

  def follow
    friend_ship_params = params.permit(:user_id, :follow_id).to_h.with_indifferent_access
    user_id = friend_ship_params[:user_id]
    following = friend_ship_params[:follow_id]
    raise 'user and following are the same' if user_id == following
    raise 'there is no user record about following' unless User.exists?(following)
    raise 'there is a following_id record exist' if FollowShip.exists?(user_id: user_id, following_id: following)

    User.find(user_id).follow_ships.create(following_id: following)
    render(json: { success: true, error: nil })
  rescue StandardError => e
    render(json: { success: false, error: e.message })
  end
end
