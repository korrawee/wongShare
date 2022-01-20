class BaansharesController < ApplicationController
    def index
        puts 'eeeeeeeeeeee'
        puts params
        puts 'eeeeeeeeeeee'
        @baansToday = Baan.getAllBaanToday(params[:id])
        @baansOtherDay = Baan.getAllBaanOtherday(params[:id])
    end

    def show
        @baanId = params[:id]
        baan = Baan.find_by_id(@baanId)
        @wongs = baan.getAllWong
    end

    def delete
        @baanId = params[:id]
        baan = Baan.find_by_id(@baanId)
        @wongs = baan.getAllWong
        puts '88888888888888'
        puts params
        puts '88888888888888'
        render json: {html: render_to_string(partial: 'table')} 
    end

    def pay
        wong = Wong.find_by_id(params[:w_id])
        if wong.paid == 0
            payUpdated = wong.interest + wong.fee
        else
            payUpdated = wong.paid + wong.interest
        end
        if wong.update(paid: payUpdated,status: true)
            flash[:success] = "ส่งยอดวง#{wong.name} เรียบร้อย!!"
            wong.save!
        else
            notice[:error] = "เกิดข้อผิดพลาด กรุณาลองอีกครั้ง"
        end
        redirect_to baanshare_path(params[:id])
    end
    def pay_all
        
    end
end
