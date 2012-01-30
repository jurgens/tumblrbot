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
  field :processed_at, type: Time

  validates :url, presence: true, format: {with: URI::regexp(%w(http https)) }, uniqueness: {message: "is a duplicate"}
  validates :status, inclusion: {in: STATUSES}

  scope :pending, where(status: PENDING)
  scope :success, where(status: SUCCESS)
  scope :error, where(status: ERROR)

  def success
    self.status = SUCCESS
    self.processed_at = Time.now
    self.save
  end

  def error(message)
    self.status = ERROR
    self.status_message = message
    self.processed_at = Time.now
    self.save
  end

  def self.last_time
    last = Job.all(sort: [[:processed_at, :desc]]).first
    last.processed_at unless last.blank?
  end

  def self.clear
    self.destroy_all
  end

  def self.counters
    {
      pending:  Job.pending.count,
      error:    Job.error.count,
      success:  Job.success.count
    }
  end
end
