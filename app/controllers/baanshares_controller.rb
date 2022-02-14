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
    def new 
        @baan = Baan.new
        if params[:baan]
            if @baan.update(params.required(:baan).permit(:name, :tel,:account_id))
                
              @baan.save!
      
              flash[:success] = "สร้างบ้าน #{@baan.name} สำเร็จ !!!"
              redirect_to baanshare_path(@baan.id)
              puts 'nnnnnnnnnnnnnnnnnnnn'
            end
          end
    end
    def delete
        @baanId = params[:id]
        baan = Baan.find_by_id(@baanId)        
        params[:w_ids] ||= []
        baan.delete(params[:w_ids]) if params[:w_ids].length > 0
        @wongs = baan.getAllWong
        redirect_to baanshare_path(params[:id])
    end

    def pay(*args)
        if params[:b_id].present?
            wong = Wong.find_by_id(params[:w_id])
            if wong.play_cycle == nil
                wong.play_cycle = wong.getCurrentCycle
            end
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
            redirect_to baanshare_path(params[:b_id])
        else
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
            redirect_to baanshare_path(params[:id])
        end
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
