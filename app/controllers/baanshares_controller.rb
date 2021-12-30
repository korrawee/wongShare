class BaansharesController < ApplicationController
    def index
    end

    def show
        @baanId = params[:id]
        baan = Baan.find_by_id(@baanId)
        @wongs = baan.getAllWong
        
    end
end
