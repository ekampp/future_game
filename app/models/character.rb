class Character
  include Mongoid::Document

  # Fields
  field :name, type: String
  field :description, type: String
  field :type, type: String
  field :energy, type: Integer, default: 5
  field :energy_regeneration, type: Integer, default: 2

  # Relations
  belongs_to :user

  # Validations
  validates :name, presence: true
  validates :type, inclusion: { in: %w(gladiator techie) }
  validates :energy, numericality: true
  validates :energy_regeneration, numericality: true

  #
  # Subtracts the given +amount+ of energy from the character's energy level.
  # If this is not possible (i.e. the character's energy would drop below 0)
  # this will return false. Otherwise it will return true.
  #
  # NOTE: That this method is appended with a bang (!), which means that this
  #       will alter the character and save it directly. <emil@kampp.me>
  #
  def subtract_energy! amount
    if (self.energy - amount) >= 0 # Ensures enough energy
      self.energy -= amount
      self.save
    else
      false
    end
  end

  #
  # Regerates the character's energy with the amount indicated in the
  # +energy_regeneration+ field. This will be called every 20 minues
  # by a cron job.
  #
  # TODO: Create the CRON task to run this. <emil@kampp.me>
  #
  def regenerate_energy!
    self.energy += self.energy_regeneration
    self.save
  end

end
