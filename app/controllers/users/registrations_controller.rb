class Users::RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.new(profile_params)
    @user.save
    super
  end

  private
  def profile_params
    params.require(:user).permit(:email, :nickname, profile_attributes: [:first_name, :family_name, :first_name_kana, :family_name_kana,:birthday])
  end
 
end
