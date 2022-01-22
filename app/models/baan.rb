class Baan < ApplicationRecord
    has_many :wongs
    has_one :account

    #INSTANCE METHODs

    def delete(ids)
        ids.each do |id|
            Wong.find_by_id(id.to_i).destroy
        end
    end
        # GETTER METHODs
    def getAllWongIds(wongs)
        ids = []
        wongs.each do |w|
            if w.isActionDay() && w.status == false
                ids.push(w.id)
            end
        end
        return ids
    end

    def getAvailable()
        count = 0
        wongs.each do |w|
            if w.play_cycle
                if Wong.getCurrentCycleById(w.id) < w.play_cycle
                    count +=1
                end
            else
                count += 1
            end
        end
        return count
    end
    def getAlreadyPlay()
        count = 0
        wongs.each do |w|
            if w.play_cycle
                if Wong.getCurrentCycleById(w.id) <= w.play_cycle
                    count +=1
                end
            end
        end
        return count
    end

    def getTodayIncome()
        total = 0
        wongs.each do |w|
           total += w.getTodayProfit()
        end
        if total == 0
            return '-'
        end
        total
    end
    
    def getAllWong
        wongs = Wong.where(baan_id: id)
    end

    def getWongCount
        getAllWong.count
    end

    # CLASS METHODs

    def self.getAllBaanInAccount(accId)
        Baan.where(account_id: accId)
    end

    def self.getAllBaanToday(accId)
        baans = Baan.getAllBaanInAccount(accId)
        baanHaveAction = []
        baans.each do |b|
            b.wongs.each do |w|
                if w.isActionDay()
                    baanHaveAction << b
                    break
                end
            end
        end
        baanHaveAction
    end

    def self.getAllBaanOtherday(accId)
        baans = Baan.getAllBaanInAccount(accId)
        baanHaveAction = []
        wongActionCount = 0
        baans.each do |b|
            b.wongs.each do |w|
                if w.isActionDay()
                    wongActionCount += 1                   
                end
            end
            if wongActionCount == 0
                baanHaveAction << b
            else
                wongActionCount = 0
            end
        end
        baanHaveAction
    end

end
