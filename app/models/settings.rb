class Settings
  include Mongoid::Document

  field :key, type: String
  field :value, type: String

  validates :key, :value, presence: true

  def self.status
    row = Settings.first(conditions: {key: 'status'} )
    row.value
  end

  def self.status=(value)
    row = Settings.find_or_create_by key: 'status'
    row.value = value
    row.save
  end
end
