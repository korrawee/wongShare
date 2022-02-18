class SummaryController < ApplicationController
  def index
    @start = selected_date(:start_date)
    @end = selected_date(:end_date)
    
    #Display today
    @records = Summary.where(created: @start..@end, account_id: current_account.id)
    puts 'oooooooooooooo'
    puts @records
    puts 'oooooooooooooo'
    @summ = Summary.summary(@records)
  end

  private

  def selected_date(symbol)
      params[:select].present? && params[:select][symbol].present? ? Date.parse(params[:select][symbol]) : Date.current
  end
end
