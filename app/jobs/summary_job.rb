class SummaryJob < ApplicationJob
  queue_as :default

  around_perform :around_cleanup

  def perform(d)
    ::Summary.create!(created: Date.parse(d))
    puts 'performed====================='
  end

  private
  def around_cleanup
    # Do something before perform
    puts 'BEFORE performed====================='
    yield
    # Do something after perform
    puts 'AFTER performed====================='
    seconds = ( DateTime.current.seconds_until_end_of_day + 5 ).seconds
    SummaryJob.set(:wait => 1.minutes).perform_later(self.arguments.first)
  end
end
