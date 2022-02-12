class WongsharesController < ApplicationController
  
  def show
    @wongId = params[:id]
    @baanId = params[:baanId]

    @wong = Wong.find_by_id(@wongId)
    @baanName = Baan.find_by_id(@baanId).name
    @currentCycle = Wong.getCurrentCycleById(@wongId)
    @playDate = Wong.getPlayDateById(@wongId)
    @totalCost = Wong.getTotalCostById(@wongId)
    @alreadyPaid = @wong.paid
    @remaining = @totalCost - @alreadyPaid
    puts "================================"
    puts params[:id]
    puts params[:baanId]
    puts @currentCycle
    puts @playDate
    puts "================================"
  end

  def update
    @wong = Wong.find_by_id(params[:id])
    if @wong.update(params.require(:wong).permit(:income))
      createSummary(@wong)
      flash[:success] = 'อัพเดตดอกเบี้ยที่ได้รับเรียบร้อย!'
      redirect_to wongshare_path(params[:id],:baanId =>params[:baanId])
    elsif @wong.update(params.require(:wong).permit(:name, :wong_type, :deposite, 
      :people, :interest, :fee, :fee_type, :income,
      :start_date, :period, :play_cycle))
      flash[:success] = 'แก้ไขข้อมูลสำเร็จ!!'
      redirect_to wongshare_path(params[:id],:baanId =>params[:baanId])
    else
      flash[:error] = 'แก้ไขไม่ข้อมูลสำเร็จ!!'
      redirect_to edit_wongshare_path(params[:id],:baanId => params[:baanId])
    end
  end

  def new
    @wong = Wong.new()
    @baanId = params[:baanId] if params[:baanId].present?
    Wong.should_validate()
    if params[:wong]
      if @wong.update(params.required(:wong).permit(:name, :wong_type,
                                                  :deposite, :people, :interest,
                                                  :fee, :fee_type, :income, :start_date,
                                                  :period, :play_cycle,:baan_id))
          
        @wong.save! if createSummary(@wong)

        flash[:success] = "สร้างวง #{params[:name]} สำเร็จ !!!"
        redirect_to baanshare_path(@wong.baan_id)
        puts 'nnnnnnnnnnnnnnnnnnnn'
      end
    end
    puts 'nnnnnnnnnnnnnnnnnnnn'
    puts 'nnnnnnnnnnnnnnnnnnnn'
  end

  def edit
    @wong = Wong.find_by_id(params[:id])
    @baanId = params[:baanId]
    puts '99999999999999999'
    puts @wong
    puts params
    puts '99999999999999999'
    if params[:wong]
      if @wong.update(params.require(:wong).permit(:name, :wong_type, :deposite, 
        :people, :interest, :fee, :fee_type, :income,
        :start_date, :period, :play_cycle))
        flash[:success] = 'แก้ไขข้อมูลสำเร็จ!!'
        redirect_to wongshare_path(params[:id],:baanId =>params[:baanId])
      else
        flash[:error] = 'แก้ไขไม่ข้อมูลสำเร็จ!!'
        redirect_to edit_wongshare_path(params[:id],:baanId => params[:baanId])
      end
    end
  end
  
  def pay
    @wong = Wong.find_by_id(params[:id])
    pay = @wong.paid + params[:wong][:cycle].to_i * @wong.interest
    pay += @wong.fee if @wong.fee_type === "จ่ายงวดแรก" && @wong.paid == 0
    if @wong.update(paid: pay)
      @wong.save!
      puts 'ppppppppp'
      puts @wong.paid
      puts params[:wong][:cycle]
      puts 'ppppppppp'
      flash[:success] = 'ชำระเงินสำเร็จ!!!'
    else
      flash[:error] = "มีบางอย่างผิดพลาด กรุณาลองอีกครั้ง."
    end
    redirect_to wongshare_path(@wong.id,:baanId =>params[:baanId])
  end

  def bit
    @wong = Wong.find_by_id(params[:id])
    if @wong.update(params.require(:wong).permit(:bit))
      @wong.save!
      flash[:success] = "บิทวง#{@wong.name} จำนวน #{@wong.bit} บาทสำเร็จ!!"
      redirect_to pay_baanshare_path(w_id: @wong.id,id: params[:baanId]), method: :post
    else
      flash[:error] = "มีบางอย่างผิดพลาด กรุณาลองอีกครั้ง."
      redirect_to baanshare_path(params[:baanId])
    end
  end

  private
  def isNumeric(str)
    params[:bit] =~ /(0|[1-9][0-9]*)/
  end

  def createSummary(wong)
    today = DateTime.current.in_time_zone('Asia/Bangkok')
    sum = Summary.where(created: today).first
    if sum.present? == false
      income = wong.getTodayIncome
      outcome = wong.getTodayPaid
      result = wong.getTodayProfit
      Summary.create!(created: today, income: income, outcome: outcome, result: result)
    else
      income = sum.income + wong.getTodayIncome
      outcome = sum.outcome + wong.getTodayPaid
      result = income - outcome
      sum.update(income: income, outcome: outcome, result: result)
      sum.save!
    end
  end
end
