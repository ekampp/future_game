class CharacterMailer < ActionMailer::Base
  default from: "do-not-reply@future-game.com"

  #
  # Sends a mail to the +character+'s user, informing him that the character
  # has been born, and what the user can do now.
  #
  def created character
    @character = character
    mail to: character.user.email, subject: t('character_mailer.created.subject', name: character.name)
  end

  #
  # Sends a mail to the +character+'s user, informing him that there have been
  # changes to the +character+.
  #
  def updated character
    @character = character
    mail to: character.user.email, subject: t('character_mailer.updated.subject', name: character.name)
  end

  #
  # Sends an email to the user, telling him that the character has been destroyed.
  #
  def destroyed character
    @character = character
    mail to: character.user.email, subject: t('character_mailer.destroyed.subject', name: character.name)
  end
end
