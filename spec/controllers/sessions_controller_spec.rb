require 'spec_helper'

describe SessionsController do

  #
  # NOTE: That since I'm using onmiauth, it's a big problem to test the correct
  #       behaviour, so this will have to be build on later in the process. For
  #       now, we are just testing that the action is present.
  #       <emil@kampp.me>
  #
  describe "#create" do
    it { should respond_to :create }
  end

  describe "#new" do
    it { should respond_to :new }

    context "when logged in" do
      let(:user) { create(:user) }
      before { login_with user; get :new }
      it { should redirect_to my_account_path }
    end

    context "when logged out" do
      before { logout; get :new }
      it { should render_template :new }
    end
  end
end
