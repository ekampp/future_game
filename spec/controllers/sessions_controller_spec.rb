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
      before { controller.stub(:auth_hash).and_return {} }

    describe "when existing user" do
      let(:user) { create :user }
      before { User.stub(:find_or_initialize_by).and_return user }
      before { controller.current_user = user; post :create }

      context "variables" do
        it { assigns(:user).should eq user }
        it { controller.current_user.should eq user }
        it { session[:user_id].should eq user.id }
      end

      context "should redirect to stored location" do
        before { controller.stub(:get_stored_location).and_return "/hej" }
        it { pending "TODO: Apparently the controller stub is not working properly. <emil@kampp.me>";
          response.should redirect_to "/hej" }
      end
    end
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
