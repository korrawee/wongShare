class Wong < ApplicationRecord
    belongs_to :baan
    serialize :discount_tracking,Array

    before_create :setFirstDiscount

    def nextCycle()
        currentCycle = Wong.getCurrentCycleById(id)
        date = start_date + (currentCycle+1) * period
        return date
    end

    def getTodayProfit()
        return getTodayIncome - getTodayPaid        
    end
    
    def getTodayPaid()
        if isActionDay()
            return interest
        else
            return 0
        end
    end

    def getTodayIncome()
        if Wong.getCurrentCycleById(id) == play_cycle
            deposite
        else
            return 0
        end
    end

    def isActionDay()
        days = Wong.getDaysFromStart(id)
        if (days % period == 0)
            true
        else
            false
        end
    end

    #ดึงยอดที่ต้องจ่ายทั้งหมด
    def self.getTotalCostById(wongId)
        wong = Wong.find_by_id(wongId)
        wongType = wong.wong_type
        total = (wong.people * wong.interest) + wong.fee
        case (wongType)
        when 'ดอกตาม'
            return total
        when 'บิทดอกตาม' 
            if wong.bit == 0
                return total            
            else
                payBitCycle = wong.people - wong.play_cycle
                paidCycle = wong.people - payBitCycle
                total = (paidCycle * wong.interest) + (payBitCycle * (wong.interest + wong.bit)) + wong.fee
                return total
            end
        when 'ขั้นบันได'
            return total
        when 'บิทลดต้น' 
            if Wong.getCurrentCycleById(wongId) == 1
                return total
            else
                discounts = wong.discount_tracking
                total = wong.fee
                discounts.each do |disc|
                    total += disc
                end
                return total
            end
        else
            puts 'wong type not found..'
        end
    end

    def getTotalCost()
        total = (people * interest) + fee
        case (wong_type)
        when 'ดอกตาม'
            return total
        when 'บิทดอกตาม' 
            if bit == 0
                return total          
            else
                payBitCycle = people - play_cycle
                paidCycle = people - payBitCycle
                total = (paidCycle * interest) + (payBitCycle * (interest + bit)) + fee
                return total
            end
        when 'ขั้นบันได'
            return total 
        when 'บิทลดต้น' 
            if getCurrentCycle() == 1
                return total
            else
                total = fee
                discount_tracking.each do |disc|
                    total += disc
                end
                return total
            end
        else
            puts 'wong type not found..'
        end
    end

    #ดึงวันที่ลงเล่น
    def self.getPlayDateById(wongId)
        wong = Wong.find_by_id(wongId)
        startDate = wong.start_date
        playCycle = wong.play_cycle
        if playCycle == nil 
             return nil 
        end
        period = wong.period
        offset = playCycle * period
        startDate + offset
    end

    def getPlayDate()
        if play_cycle == nil 
             return nil 
        end
        offset = play_cycle * period
        start_date + offset
    end


    def self.getCurrentCycleById(wongId)
        days = Wong.getDaysFromStart(wongId)
        period = Wong.find_by_id(wongId).period
        if (days % period == 0)
            amt = days / period
        else
            amt = (days / period).floor
            if amt < 1
                amt = 1
            end
        end
        amt
    end

    def getCurrentCycle()
        days = Wong.getDaysFromStart(id)
        if (days % period == 0)
            amt = days / period
        else
            amt = (days / period).floor + 1
        end
        amt
    end

    #ดึงจำนวนวันตั้งแต่เร่ิมเล่นจนถึงปัจจุบัน
    def self.getDaysFromStart(wongId)
        dateTime = Wong.find_by_id(wongId).start_date
        startDate = Date.parse(dateTime.to_s)
        today = Date.parse(DateTime.now().to_s)
        days = (today - startDate).to_i
    end

    private
    #เก็บดอกที่ต้องจ่ายในแต่ละงวด สำหรับวงบิทลดต้น
    def setFirstDiscount
        self.discount_tracking = [self.interest]
        puts self.discount_tracking
    end
end

