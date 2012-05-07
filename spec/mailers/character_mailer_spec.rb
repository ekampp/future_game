require "spec_helper"

describe CharacterMailer do
  describe "#created" do
    let(:user) { create :user }
    let(:character) { create :character, user: user }
    let(:mail) { CharacterMailer.created character }

    context "subject" do
      it { mail.subject.should eq "The legend, #{character.name} has been born." }
    end

    context "to" do
      it { mail.to.first.should eq character.user.email }
    end

    context "from" do
      it { mail.from.first.should eq "do-not-reply@future-game.com" }
    end

    context "body" do
      it { mail.body.encoded.should match "Welcome, #{character.name}" }
    end
  end

  describe "#updated" do
    let(:user) { create :user }
    let(:character) { create :character, user: user }
    let(:mail) { CharacterMailer.updated character }

    context "subject" do
      it { mail.subject.should eq "#{character.name.to_s.titleize} has new stuff!" }
    end

    context "to" do
      it { mail.to.first.should eq character.user.email }
    end

    context "from" do
      it { mail.from.first.should eq "do-not-reply@future-game.com" }
    end

    context "body" do
      it { mail.body.encoded.should match "#{character.name.to_s.titleize}" }
    end
  end


  describe "#destroyed" do
    let(:user) { create :user }
    let(:character) { create :character, user: user }
    let(:mail) { CharacterMailer.destroyed character }

    context "subject" do
      it { mail.subject.should eq "We are sorry to tell you, but #{character.name.to_s.titleize} has been killed." }
    end

    context "to" do
      it { mail.to.first.should eq character.user.email }
    end

    context "from" do
      it { mail.from.first.should eq "do-not-reply@future-game.com" }
    end

    context "body" do
      it { mail.body.encoded.should match "#{character.name.to_s.titleize}" }
    end
  end
end