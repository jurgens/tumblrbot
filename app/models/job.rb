class Job
  include Mongoid::Document
  include Mongoid::Timestamps

  PENDING = 'pending'
  SUCCESS = 'success'
  ERROR = 'error'
  STATUSES = [PENDING, SUCCESS, ERROR]

  field :url, type: String
  field :status, type: String, default: PENDING
  field :status_message, type: String

  validates :url, presence: true
  validates :status, inclusion: {in: STATUSES}

  scope :pending, where(status: PENDING)

  def success
    self.status = SUCCESS
    self.save
  end

  def error(message)
    self.status = ERROR
    self.status_message = message
    self.save
  end

  def self.last_time
    Job.all(sort: [[:updated_at, :desc]]).first.updated_at
  end
end
