require 'spec_helper'

describe CharactersController do

  describe "#index" do
    it { should_not respond_to :index }
  end

  describe "#create" do
    it { should respond_to :create }
    let(:user) { create :user }
    let(:character) { build :character, user: user }

    context "not logged in" do
      before { logout }
      before { post :create }
      it { response.should redirect_to login_path(msg: "login_required") }
    end

    context "logged in" do
      before { login_with user }

      context "posting correct data" do
        before { post :create, character: character.attributes }
        it { assigns(:character).user.should eq user }
        it { response.should redirect_to character_path(user.characters.last) }
      end

      context "posting incorrect data" do
        before { post :create, character: { blabla: "hej" } }
        it { assigns(:character).user.should eq user }
        it { response.should render_template :new }
      end
    end
  end

  describe "#show" do
    it { should respond_to :show }
    let(:user) { create :user }
    let(:character) { create :character, user: user }

    context "not logged in" do
      before { logout }
      before { get :show }
      it { response.should redirect_to login_path(msg: "login_required") }
    end

    context "logged in" do
      before { login_with user; get :show, id: character.id }
      it { assigns(:character).user.should eq user }
      it { response.should render_template :show }
    end

    context "when called with the wrong id" do
      before { login_with user }
      it { expect{ get :show, id: "bang" }.to raise_error }
    end
  end

  describe "#edit" do
    it { should respond_to :edit }
    let(:user) { create :user }
    let(:character) { create :character, user: user }

    context "not logged in" do
      before { logout }
      before { get :edit, id: 1 }
      it { response.should redirect_to login_path(msg: "login_required") }
    end

    context "logged in" do
      before { login_with user; get :edit, id: character.id }
      it { assigns(:character).user.should eq user }
      it { response.should render_template :edit }
    end

    context "when called with the wrong id" do
      before { login_with user }
      it { expect{ get :show, id: "bang" }.to raise_error }
    end
  end

  describe "#update" do
    it { should respond_to :update }
    let(:user) { create :user }
    let(:character) { create :character, user: user }

    context "not logged in" do
      before { logout; put :update, id: "hej" }
      it { response.should redirect_to login_path(msg: "login_required") }
    end

    context "logged in" do
      before { login_with user }

      context "putting correct data" do
        before { put :update, id: character.id, character: { name: "hej" } }
        it { assigns(:character).should eq character }
        it { assigns(:character).user.should eq user }
        it { response.should redirect_to character_path(character) }
      end

      context "putting incorrect data" do
        before { put :update, id: character.id, character: { blabla: "hej" } }
        it { assigns(:character).should eq character }
        it { assigns(:character).user.should eq user }
        it { pending "This renders the character_mailer/updated template instead";
          response.should render_template :edit }
      end
    end
  end

  describe "#destroy" do
    it { should respond_to :destroy }
    let(:user) { create :user }
    let(:character) { create :character, user: user }

    context "not logged in" do
      context "retrieving the right id" do
        before { logout; delete :destroy, id: character.id }
        it { response.should redirect_to login_path(msg: "login_required") }
      end

      context "retrieving the wrong" do
        before { logout; delete :destroy, id: "bang" }
        it { response.should redirect_to login_path(msg: "login_required") }
      end
    end

    context "logged in" do
      before { login_with user }

      context "retrieving incorrect id" do
        it { expect{ delete :destroy, id: "hej" }.to raise_error }
      end

      context "retrieving correct id" do
        before { delete :destroy, id: character.id }
        it { assigns(:character).should eq character }
        it { assigns(:character).user.should eq user }
        it { response.should redirect_to my_account_path }
      end
    end
  end
end
