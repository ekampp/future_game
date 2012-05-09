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
      it { mail.to.first.to_s.should eq character.user.info[:email].to_s }
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
      it { mail.subject.should eq "#{character.name} has new stuff!" }
    end

    context "to" do
      it { mail.to.first.should eq character.user.info[:email] }
    end

    context "from" do
      it { mail.from.first.should eq "do-not-reply@future-game.com" }
    end

    context "body" do
      it { mail.body.encoded.should match "#{character.name}" }
    end
  end


  describe "#destroyed" do
    let(:user) { create :user }
    let(:character) { create :character, user: user }
    let(:mail) { CharacterMailer.destroyed character }

    context "subject" do
      it { mail.subject.should eq "We are sorry to tell you, but #{character.name} has been killed." }
    end

    context "to" do
      it { mail.to.first.should eq character.user.info[:email] }
    end

    context "from" do
      it { mail.from.first.should eq "do-not-reply@future-game.com" }
    end

    context "body" do
      it { mail.body.encoded.should match "#{character.name}" }
    end
  end
end
