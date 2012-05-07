class User
  include Mongoid::Document

  #
  # This is to avoid loosing users permanently.
  # A cronjob will run through this weekly, and remove users marked for
  # deletion.
  #
  # TODO: Make a cronjob to rub through old, deleted users. <emil@kampp.me>
  #
  include Mongoid::Paranoia

  # Field definitions
  field :role, type: String, :default => "player"
  field :email, type: String
  field :provider, type: String
  field :uid, type: String
  field :info, type: Hash

  # Indexes
  index :uid, unique: true
  index :email, unique: true
  index :provider
  index :role

  # Relations
  has_many :characters

  # Validations
  validates :email,
    presence: true,
    uniqueness: { :case_sensitive => false }
  validates :uid,
    presence: true,
    uniqueness: true
  validates :provider,
    presence: true
  validates :role,
    inclusion: { in: %w(player admin) }

end
