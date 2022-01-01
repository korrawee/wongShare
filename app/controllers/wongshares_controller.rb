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
      flash[:success] = 'อัพเดตดอกเบี้ยที่ได้รับเรียบร้อย!'
      redirect_to wongshare_path(params[:id],:baanId =>params[:baanId])
    end
  end
  def new
  end
  def edit
  end
end
