class Summary < ApplicationRecord
    default_scope { all } 
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

    def self.summary(s_list)
        summ = 0;
        s_list.each{ |s|
            summ += s.result
        }
        summ
    end
end
