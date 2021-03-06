class SessionsController < Clearance::BaseController
    before_action :redirect_signed_in_users, only: [:new]
    skip_before_action :require_login, only: [:create, :new, :destroy], raise: false

    def create
      @user = authenticate(params)

      sign_in(@user) do |status|
        if status.success?
          render json: @user
        else
          flash.now.alert = status.failure_message
          render json: @user
        end
      end
    end

    def destroy
      sign_out
      redirect_to url_after_destroy
    end

    def new
      render template: "sessions/new"
    end

    private

    def redirect_signed_in_users
      if signed_in?
        redirect_to wall_url(params[:id] = current_user.id)
      end
    end

    def url_after_create
      wall_url(params[:id] = current_user.id)
    end

    def url_after_destroy
      sign_in_url
    end

  end
