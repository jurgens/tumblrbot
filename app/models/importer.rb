require 'csv'

class Importer
  def run(file_name)
    report = {successes: 0, failures: 0, errors: [] }

    CSV.foreach(file_name) do |row|
      url = row[0]
      job = Job.new url: url
      if job.save
        report[:successes] += 1
      else
        report[:failures] += 1
        report[:errors] << job.errors.full_messages
      end
    end
    report
  end
end