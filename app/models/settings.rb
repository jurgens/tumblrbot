class Settings
  include Singleton
  include Mongoid::Document

  field :status, type: String
  field :delay, type: String

  validates :status, presence: true, inclusion: { in: ['on', 'off'] }
  validates :delay, presence: true

  #def self.status
  #  row = Settings.first(conditions: {key: 'status'} )
  #  row.value unless row.blank?
  #end
  #
  #def self.status=(value)
  #  row = Settings.find_or_create_by key: 'status'
  #  row.value = value
  #  row.save
  #end

  #def self.method_missing(method, *args, &block)
  #  if method.to_s =~ /^(.+)=$/
  #    raise ArgumentError if args.length == 0
  #    instance = Settings.instance
  #    instance.send($1.to_sym, args[0].to_s)
  #    row.save
  #  else
  #    row = Settings.first conditions: {key: method}
  #    row.value unless row.blank?
  #  end
  #end
  #
  #def self.status?
  #  puts " status = #{self.instance.status}"
  #  self.instance.status == 'on'
  #end
end
