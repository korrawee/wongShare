class Wong < ApplicationRecord
    belongs_to :baan
    has_many :summaries
    serialize :discount_tracking,Array

    before_create :setFirstDiscount

    attr_accessor :should_validate
    validates :name, presence: true, uniqueness:{message: 'ชื่อนี้ถูกใช้แล้ว'},on: :update, if: lambda { should_validate.present? }
    validates :wong_type, presence: true, on: :update, if: lambda { should_validate.present? }
    validates :deposite, presence: true, on: :update, if: lambda { should_validate.present? }
    validates :people, presence: true, on: :update, if: lambda { should_validate.present? }
    validates :interest, presence: true, on: :update, if: lambda { should_validate.present? }
    validates :fee, presence: true, on: :update, if: lambda { should_validate.present? }
    validates :fee_type, presence: true, on: :update, if: lambda { should_validate.present? }
    validates :start_date, presence: true, on: :update, if: lambda { should_validate.present? }
    validates :period, presence: true, on: :update, if: lambda { should_validate.present? }
    
    def unpayCycle()
        count = 0
        alreadyPaid = paid
        cycle = getCurrentCycle()
        return count if cycle == 0 
        if paid != 0
            alreadyPaid -= fee if fee_type === "จ่ายงวดแรก"
            alreadyPaid -= bit if bit > 0

            paidCycle = paid / interest
            count = cycle - paidCycle

            return count
        else
            return cycle
        end
        
    end
    def self.should_validate()
        should_validate = true
    end

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
            status = false if status == true
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
            amt = (days / period).floor + 1
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

