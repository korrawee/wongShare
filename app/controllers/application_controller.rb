class ApplicationController < ActionController::Base
    before_action :isSummary
    def isSummary
        if account_signed_in?
            td = Date.current.in_time_zone('Bangkok').strftime('%d-%m-%Y')
            tmr = Date.tomorrow.in_time_zone('Bangkok').strftime('%d-%m-%Y')
            puts "Summary.none? : #{Summary.none?}"
            if Summary.none?
                SummaryJob.perform_later(td)
                puts "INSIDE Summary.none?"
            end
        end
    end
end
