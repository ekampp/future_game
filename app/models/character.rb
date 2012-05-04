class Character
  include Mongoid::Document

  # Fields
  field :name, :type => String

  # Relations
  belongs_to :user

  # Validations
  validates :name, presence: true

end
