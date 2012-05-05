require 'spec_helper'

describe Character do

  # Required fields
  it { should have_field(:name).of_type(String).with_default_value_of('player') }
  it { should belong_to(:user).of_type(User) }

  # Validations
  it { should validate_presence_of(:name) }

end
