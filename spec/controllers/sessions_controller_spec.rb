require "rails_helper"

describe SessionsController do
  context "GET #new" do
    context "without a password" do
      it "does not set current user" do
        user = create(:user)
        allow(controller).to receive(:current_user).and_return(user)

        post :create, params: { session: { email: user.email } }

        expect(session[:user_id]).to eq nil
      end

      it "renders new" do
        user = create(:user)

        post :create, params: { session: { email: user.email } }

        expect(response).to render_template(:new)
      end

      it "sets the flash[:alert]" do
        user = create(:user)

        post :create, params: { session: { email: user.email } }

        expect(flash[:alert]).to match I18n.t("sessions.create.flash.alert")
      end
    end
  end

  context "User already signed in" do
    it "renders user#show" do
      user = create(:user)
      allow(controller).to receive(:current_user).and_return(user)

      get :new

      expect(response).to redirect_to(users_path)
    end

    it "sets the flash[:alert]" do
      user = create(:user)
      allow(controller).to receive(:current_user).and_return(user)

      get :new

      expect(flash[:alert]).to match I18n.t("sessions.new.flash.alert")
    end
  end
end
