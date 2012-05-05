class User
  include Mongoid::Document

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
