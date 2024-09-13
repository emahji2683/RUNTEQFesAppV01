class GuestSessionsController < ApplicationController
    def create
      user = User.create(
        email: "guest_#{SecureRandom.hex(10)}@example.com",
        password: SecureRandom.urlsafe_base64,
        name: "ゲストユーザー"
      )
      session[:user_id] = user.id
      flash[:notice] = "ゲストユーザーとしてログインしました"
      redirect_to root_path
    end
end
