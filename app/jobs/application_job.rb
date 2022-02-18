class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked
  after_perform do |job|
    puts 'SETTING after_perform'
    job.class.set(wait: 1.days).perform_later(job.arguments.first, job.arguments.last)
    puts 'DONE IN after_perform'
  end
  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
end
