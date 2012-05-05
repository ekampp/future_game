require "spec_helper"

describe "users/new" do
  let(:user) { FactoryGirl.build(:user) }
  before { assign :user, user }
  before { render }

  describe "login form" do
    it { rendered.should have_selector "form" }
    it { rendered.should have_selector "form input[type='submit']" }
  end

  describe "vendor logins" do
    pending "Uncomment this, when the signup form has been completed"
    # it { rendered.should have_selector "a#facebook_login" }
    # it { rendered.should have_selector "a#twitter_login" }
  end
end
