class Summary < ApplicationRecord
    def setAllIncome(baans)
        amount = 0
        baans.each do |b|
            b.getAllWong.each do |w|
                amount += w.getTodayIncome()
            end
        end
        puts '-------------getAllIncome-------------'
        puts amount
        puts '-------------getAllIncome-------------'
        update!(income: amount, result: amount - outcome)
    end

    def setAllOutcome(baans)
        amount = 0
        baans.each do |b|
            b.getAllWong.each do |w|
                amount += w.getTodayPaid()
            end
        end
        puts '-------------getAllIncome-------------'
        puts amount
        puts '-------------getAllIncome-------------'
        update!(outcome: amount, result: income - amount)
    end


end
