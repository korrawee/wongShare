# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
a = Account.create(email: 'w@gmail.com', password: '111111')
b1 = Baan.create(name: "แม่น้ำใส",account_id: a.id)
b2 = Baan.create(name: 'กระเพราะป่า', account_id: a.id)
w1 = Wong.create(name: 'วงกลม1',baan_id: b1.id, wong_type: 'บิทดอกตาม', 
                fee_type: 'จ่ายงวดแรก', deposite: 35000, people: 35, 
                interest:1000,fee: 800, period: 7,start_date:Date.parse('2021-12-01'),
                play_cycle: 30, bit: 300, paid: 5000, income: 10000
                )
w2 = Wong.create(name: 'วงกลม',baan_id: b2.id, wong_type: 'บิทดอกตาม', 
                fee_type: 'จ่ายงวดแรก', deposite: 35000, people: 35, 
                interest:1000,fee: 800, period: 30,start_date:Date.parse('2021-12-01'),
                play_cycle: 30, bit: 300, paid: 5000, income: 10000
                )
w3 = Wong.create(name: 'วงกลม',baan_id: b1.id, wong_type: 'บิทดอกตาม', 
                fee_type: 'จ่ายงวดแรก', deposite: 35000, people: 35, 
                interest:1000,fee: 800, period: 7,start_date:Date.parse('2021-12-29'),
                play_cycle: 30, bit: 300, paid: 5000, income: 10000
                )
w4 = Wong.create(name: 'วงกลม',baan_id: b2.id, wong_type: 'บิทดอกตาม', 
                fee_type: 'จ่ายงวดแรก', deposite: 35000, people: 35, 
                interest:1000,fee: 800, period: 30,start_date:Date.parse('2021-12-15'),
                play_cycle: 30, bit: 300, paid: 5000, income: 10000
                )
