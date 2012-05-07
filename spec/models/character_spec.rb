require 'spec_helper'

describe Character do

  # Required fields
  it { should have_field(:name).of_type(String).with_default_value_of('player') }
  it { should belong_to(:user).of_type(User) }

  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_inclusion_of(:type).to_allow("gladiator", "techie") }
  it { should validate_numericality_of(:energy) }
  it { should validate_numericality_of(:energy_regeneration) }

  # Methods
  describe "#subtract_energy!" do
    it { should respond_to :subtract_energy! }

    context "when the character has enough energy" do
      let(:character) { create :character, energy: 11 }
      it { character.subtract_energy!(10).should be_true }
    end

    context "when not enough energy" do
      let(:character) { create :character, energy: 9 }
      it { character.subtract_energy!(10).should be_false }
    end
  end

  describe "#regenerate_energy!" do
    it { should respond_to :regenerate_energy! }
    context "regeration should be successful" do
      let(:character) { create :character, energy: 2, energy_regeneration: 2 }
      it { character.regenerate_energy!.should be_true }
    end
    context "starting from 2, regenerating with 2" do
      let(:character) { create :character, energy: 2, energy_regeneration: 2 }
      before { character.regenerate_energy! }
      it { character.energy.should eq 4 }
    end
  end

end
