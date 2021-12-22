class BaanshareController < ApplicationController
    def index
    end

    def show
        @baanId = params[:id]
    end
end
