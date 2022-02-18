class SummaryJob < ApplicationJob
  queue_as :default


  def perform(d,acc_id)
    puts 'START performed====================='
    ::Summary.create!(created: Date.parse(d), account_id: acc_id)
    puts "performed=====================#{acc_id}"

  end

end
