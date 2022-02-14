# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#

a = Account.create(email: 'ronnawee.somyos@gmail.com', password: '111111')




#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# wong_type = ['ขั้นบันได', 'ดอกตาม', 'บิทดอกตาม', 'บิทลดต้น']
# date_list = [Date.current.in_time_zone('Asia/Bangkok'),
#             Date.yesterday.in_time_zone('Asia/Bangkok'),
#             Date.tomorrow.in_time_zone('Asia/Bangkok')
#         ]
# depos_list = (10000..35000).step(5000).to_a
# cycle_list = (1..25).to_a
# b_list = []


# a = Account.create(email: 'w@gmail.com', password: '111111')
# 10.times{ |i|
#     b = Baan.create(name: "บ้าน #{i}",account_id: a.id)
#     b_list << b
# }
# b_list.each { |b|
#     10.times { |i|
#         depo = depos_list.sample
#         people = depo/1000
#         Wong.create(name: "วงที่ #{i}",baan_id: b.id, wong_type: wong_type.sample, 
#         fee_type: 'จ่ายงวดแรก', deposite: depo, people: people, 
#         interest:1000, fee: 800, period: 30, start_date: date_list.sample,
#         play_cycle: cycle_list.sample, paid: 8*1000, income: 0
#         )
#     }
# }


# date_list.each { |d|
#     baans = []
#     b_list.each { |b|
#         b.wongs.each{ |w|
#             if w.start_date.strftime('%d%m%Y') === d.strftime('%d%m%Y')
#                 baans << b
#                 break
#             end
#         }

#     }
#     puts baans
#     puts '-------------------'
#     s = Summary.create(created: d)
#     s.setAllIncome(baans)
#     s.setAllOutcome(baans)
#     s.save!
#     baans = []
# }



