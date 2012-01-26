class Worker

  def run
    return unless enabled && is_good_time && has_jobs
    process(Job.pending.first)
  end

  def process(job)
    return if job.status != Job::PENDING
    begin
      Tumblr.follow(user, job.url)
      job.success
    rescue
      job.error ($!.message)
    end
  end

  def user
    Authentication.first || raise('No available authentications')
  end

  def is_good_time
    Time.now - Job.last_time < delay
  end

  def delay
    (rand(2) + 3) * 60 # 3-5 minutes
  end

  def has_jobs
    Job.pending.count > 0
  end

  def enabled
    Settings.status == 'on'
  end
end
