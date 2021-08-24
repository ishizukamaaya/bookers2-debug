class RelationshipsController < ApplicationController

  def create
    current_user.follow(params[:id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unfollow(params[:id])
    redirect_back(fallback_location: root_path)
  end

  def following
    user = User.find(params[:user_id])
    @users = user.following
  end

  def follower
    user = User.find(params[:user_id])
    @users = user.follower
  end
end
