class ApplicationController < ActionController::Base
    before_action :auth
    def isSummary
        if current_account
            acc_id = current_account.id
            td = Date.current.in_time_zone('Bangkok').strftime('%d-%m-%Y')
            puts "Summary.none? : #{Summary.none?}"
            if Summary.where(account_id: acc_id).none?      # if this Account doesn't has any record.

                SummaryJob.perform_later(td, acc_id)
                puts "INSIDE Summary.none?"
            
            # Check for missing summary
            elsif Summary.check_update(acc_id)
                Summary.update(acc_id)                      # update til today
            end
        end
    end
    private
    def auth
        if authenticate_account!
            isSummary()
        end
    end
end
