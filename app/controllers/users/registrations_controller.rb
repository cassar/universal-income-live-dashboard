module Users
  class RegistrationsController < Devise::RegistrationsController
    invisible_captcha only: :create, on_spam: :repel_bot_with_invisible_captcha

    before_action :repel_bot_with_voight_kampff, only: :create
  end
end
