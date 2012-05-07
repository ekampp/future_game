require 'spec_helper'

describe UsersController do
  describe "#new" do
    context "when not logged in" do
      before { logout; get :new }
      it { should respond_to :new }
      it { should render_template :new }
      it { assigns(:user).should be_a User }
    end

    context "when logged in" do
      let(:user) { create(:user) }
      before { login_with user; get :new }
      it { should redirect_to my_account_path }
    end
  end

  describe "#edit" do
    it { should respond_to :edit }

    # A user should be able to edit his own profile
    context "your own profile" do
      let(:user) { create(:user) }
      before { login_with user; get :edit, id: user.id }
      it { should render_template :edit }
      it { assigns(:user).should eq user }
    end

    # A user trying to edit another user's profile should in fact edit his own,
    # unless he is admin.
    context "other user" do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }
      it { expect{ login_with user; get :edit, id: other_user.id }.to raise_error }
    end

    # An admin user should be able to edit another user's profile.
    context "when admin" do
      let(:user) { create(:user) }
      let(:admin) { create(:admin) }
      before { login_with admin; get :edit, id: user.id }
      it { should render_template :edit }
      it { assigns(:user).should eq user }
    end

    # If the user is not logged in, he should be redirected to the login page.
    context "when not logged in" do
      before { logout; get :edit, id: 1 }
      it { should redirect_to login_path(msg: "login_required") }
    end
  end

  describe "#update" do
    it { should respond_to :update }

    # A user should be able to update his own profile
    context "your own profile" do
      let(:user) { create(:user) }
      before { login_with user }
      before { put :update, id: user.id, user: user.attributes }
      it { assigns(:user).should eq user }
      it { should redirect_to edit_user_path(user) }
      pending "Check that the user is in fact updated."
    end

    # A user trying to edit another user's profile should in fact edit his own,
    # unless he is admin.
    context "other user" do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }
      before { login_with user }
      it { expect{ put :update, id: other_user.id, user: other_user.attributes }.to raise_error }
    end

    # An admin user should be able to edit another user's profile.
    context "when admin" do
      let(:user) { create(:user) }
      let(:admin) { create(:admin) }
      before { login_with admin }
      before { put :update, id: user.id, user: user.attributes }
      it { assigns(:user).should eq user }
      it { should redirect_to edit_user_path(user) }
    end

    # A user, not logged in, should not be able to access the update action
    context "when not logged in" do
      before { logout; put :update, id: 1, user: {} }
      it { should redirect_to login_path(msg: "login_required") }
    end
  end

  describe "#create" do
    it { should respond_to :create }

    # Creating a new profile
    context "when posting correct data" do
      let(:user) { build(:user) }
      before { post :create, user: user.attributes }
      it { assigns(:user).should be_a User }
      it { should redirect_to new_character_path }
    end

    context "posting bad data" do
      let(:user) { build(:user) }
      before { post :create, user: {} }
      it { assigns(:user).should be_a User }
      it { should render_template :new }
    end

    # A user, not logged in, should not be able to access the update action
    context "when not logged in" do
      before { logout; put :update, id: 1, user: {} }
      it { should redirect_to login_path(msg: "login_required") }
    end
  end

  describe "#destroy" do
    it { should respond_to :destroy }

    # A user should be able to update his own profile
    context "your own profile" do
      let(:user) { create(:user) }
      before { login_with user }
      before { delete :destroy, id: user.id }
      it { assigns(:user).should eq user }
      it { should redirect_to new_user_path }
      pending "Check that the user is in fact destroyed."
    end

    # A user trying to edit another user's profile should in fact edit his own,
    # unless he is admin.
    context "other user" do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }
      before { login_with user }
      it { expect{ delete :destroy, id: other_user.id }.to raise_error }
    end

    # An admin user should be able to edit another user's profile.
    context "when admin" do
      let(:user) { create(:user) }
      let(:admin) { create(:admin) }
      before { login_with admin }
      before { delete :destroy, id: user.id }
      it { assigns(:user).should eq user }
      it { should redirect_to users_path }
    end

    # A user, not logged in, should not be able to access the destroy action
    context "when not logged in" do
      before { logout; delete :destroy, id: 1 }
      it { should redirect_to login_path(msg: "login_required") }
    end
  end
end
