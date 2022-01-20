class MainController < ApplicationController
  def index
    if current_account
        @acc = current_account
        @baansToday = Baan.getAllBaanToday(@acc.id)
        @baansOtherDay = Baan.getAllBaanOtherday(@acc.id)
        @baans = Baan.all
        puts '%%%%%%%%%%%%%%%%%%%'
        puts @baansOtherDay.class
        puts '%%%%%%%%%%%%%%%%%%%'
    end
  end
end
