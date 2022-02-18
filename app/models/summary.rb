class Summary < ApplicationRecord
    default_scope { all } 
    validates :created, uniqueness: true
    def self.update(acc_id, days)
        date = Date.current - (days - 1)
        summaries = Summary.where(["account_id = ? and created > ?", acc_id, date]).order(created: :asc).limit(days) # query summay created last 7 days      
        index = 1
        while index <= days do                                  # create missing summary
            puts "BEFORE:\nLoop: #{index}\ndate: #{(date + index)}\nsummaries: #{summaries.each{|s| print "#{s.created}\n"}}\n=========="
            begin 
                Summary.create!(created: (date + index).strftime('%d-%m-%Y'), account_id: acc_id)
                summaries = Summary.where(["account_id = ? and created > ?", acc_id, date]).order(created: :asc).limit(days)
            rescue
                puts "\n--------DUPLICATED-------\n"
                index += 1
            end
            puts "AFTER:\nLoop: #{index}\ndate: #{(date + index)}\nsummaries: #{summaries.each{|s| print "#{s.created}\n"}}\n=========="
        end
        puts "\nSummary updated.\n"
    end

    def self.check_update(acc_id, days)
        date = Date.current - days
        summaries = Summary.where(["account_id = ? and created > ?", acc_id, date]).order(created: :asc).limit(days) # query summay created last 7 days
        puts summaries.length < days  && summaries.length > 0 
        puts summaries.length < days  && summaries.length > 0 
        puts summaries.length < days  && summaries.length > 0 
        return summaries.length < days  && summaries.length > 0                               # if summary is missing
    end

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
