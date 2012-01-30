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
    last_time = Job.last_time
    return true if last_time.blank?
    Time.now - last_time > delay
  end

  def delay
    (rand(2) + 3).minutes # 3-5 minutes
  end

  def has_jobs
    Job.pending.count > 0
  end

  def enabled
    Settings.instance.status == 'on'
  end
end
