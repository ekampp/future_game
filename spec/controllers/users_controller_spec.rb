require 'spec_helper'

describe UsersController do
  describe "#new" do
    before { get :new }
    it { should respond_to :new }
    it { should render_template :new }
    it { assigns(:user).should be_a User }
  end

  describe "#edit" do
    it { should respond_to :edit }

    # A user should be able to edit his own profile
    context "your own profile" do
      let(:user) { create(:user) }
      before { login_with user }
      before { get :edit, id: user.id }
      it { should render_template :edit }
      it { assigns(:user).should eq user }
    end

    # A user trying to edit another user's profile should in fact edit his own,
    # unless he is admin.
    context "other user" do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }
      before { login_with user }
      before { get :edit, id: other_user.id }
      it { should render_template :edit }
      it { assigns(:user).should eq user }
    end

    # An admin user should be able to edit another user's profile.
    context "when admin" do
      let(:user) { create(:user) }
      let(:admin) { create(:admin) }
      before { login_with admin }
      before { get :edit, id: user.id }
      it { should render_template :edit }
      it { assigns(:user).should eq user }
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
      it { should redirect_to edit_users_path(user) }
      pending "Check that the user is in fact updated."
    end

    # A user trying to edit another user's profile should in fact edit his own,
    # unless he is admin.
    context "other user" do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }
      before { login_with user }
      before { put :update, id: other_user.id, user: other_user.attributes }
      it { assigns(:user).should eq user }
      it { should redirect_to edit_users_path(user) }
    end

    # An admin user should be able to edit another user's profile.
    context "when admin" do
      let(:user) { create(:user) }
      let(:admin) { create(:admin) }
      before { login_with admin }
      before { put :update, id: user.id, user: user.attributes }
      it { assigns(:user).should eq user }
      it { should redirect_to edit_users_path(user) }
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
      it { should redirect_to new_users_path }
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
  end
end
