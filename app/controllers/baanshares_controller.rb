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
        puts '88888888888888'
        puts params[:checked][0]
        puts '88888888888888'       
        baan.delete(params[:checked]) if params[:checked].length > 0
        @wongs = baan.getAllWong
        respond_to do |format|
            format.html {}
            format.js {}
            format.json {}
        end
    end

    def pay(*args)
        case args.size
        when 0
            wong = Wong.find_by_id(params[:w_id])
            if wong.paid == 0 #ถ้ายังไม่เคยจ่าย
                payUpdated = wong.interest
                if wong.fee_type === "จ่ายงวดแรก"
                    payUpdated += wong.fee
                end
            else
                payUpdated = wong.paid + wong.interest
                if wong.fee_type === "จ่ายงวดรับเงิน" && wong.play_cycle == wong.getCurrentCycle
                    payUpdated += wong.fee
                end
            end
            if wong.update(paid: payUpdated,status: true)
                flash[:success] = "ส่งยอดวง#{wong.name} เรียบร้อย!!"
                wong.save!
            else
                notice[:error] = "เกิดข้อผิดพลาด กรุณาลองอีกครั้ง"
            end
        when 1
            args[0].each do |id|
                wong = Wong.find_by_id(id)
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
            end
        end
        redirect_to baanshare_path(params[:id])
    end

    def pay_all
        baan = Baan.find_by_id(params[:id])
        wongs = baan.getAllWong
        puts 'pppppppppppppppppp'
        puts baan.getAllWongIds(wongs)
        puts 'pppppppppppppppppp'
        pay(baan.getAllWongIds(wongs))
    end
end
