require 'spec_helper'

describe User do

  # Required fields
  it { should have_field(:role).of_type(String).with_default_value_of('player') }
  it { should have_field(:email).of_type(String) }
  it { should have_field(:provider).of_type(String) }
  it { should have_field(:uid).of_type(String) }
  it { should have_field(:info).of_type(Hash) }

  # Indexes
  it { should have_index_for(:email).with_options(:unique => true) }
  it { should have_index_for(:provider) }
  it { should have_index_for(:uid).with_options(:unique => true) }
  it { should have_index_for(:role) }

  # Validations
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_presence_of(:uid) }
  it { should validate_uniqueness_of(:uid) }
  it { should validate_presence_of(:provider) }
  it { should validate_inclusion_of(:role).to_allow("player", "admin") }

end
