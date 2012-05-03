class User
  include Mongoid::Document
  field :role, :type => String, :default => "player"
end
