class Worker

  def run
    return if Time.now - Job.last_time < delay
    return if Job.pending.count == 0
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

  def delay
    (rand(2) + 3) * 60 # 3-5 minutes
  end
end
