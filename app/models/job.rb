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

  validates :url, presence: true, format: {with: URI::regexp(%w(http https)) }
  validates :status, inclusion: {in: STATUSES}

  scope :pending, where(status: PENDING)
  scope :success, where(status: SUCCESS)
  scope :error, where(status: ERROR)

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

  def self.counters
    {
      pending:  Job.pending.count,
      error:    Job.error.count,
      success:  Job.success.count
    }
  end
end
