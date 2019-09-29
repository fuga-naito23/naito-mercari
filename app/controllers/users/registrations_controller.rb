class Users::RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.new(profile_params)
    @user.save
    if params[:sns_auth] == 'true'
      pass = Devise.friendly_token
      params[:user][:password] = pass
      params[:user][:password_confirmation] = pass
    end
    super
  end

  private
  def profile_params
    params.require(:user).permit(:email, :nickname, profile_attributes: [:first_name, :family_name, :first_name_kana, :family_name_kana,:birthday])
  end
end
