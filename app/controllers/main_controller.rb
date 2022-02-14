class MainController < ApplicationController
  def index
    if current_account
        today = Date.current.in_time_zone('Bangkok')
        @acc = current_account
        @baansToday = Baan.getAllBaanToday(@acc.id)
        @baansOtherDay = Baan.getAllBaanOtherday(@acc.id)
        @baans = Baan.all
        @summary = Summary.where(created: today).first
        puts '%%%%%%%%%%%%%%%%%%%'
        puts @baansOtherDay.class
        puts '%%%%%%%%%%%%%%%%%%%'
    else
      redirect_to new_account_session_path()
    end
  end
end
