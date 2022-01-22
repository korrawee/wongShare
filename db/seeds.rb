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
b2 = Baan.create(name: 'บ้าน', account_id: a.id)
b2 = Baan.create(name: 'บ้าน 1', account_id: a.id)
b2 = Baan.create(name: 'บ้าน 2', account_id: a.id)
b2 = Baan.create(name: 'บ้าน 3', account_id: a.id)
b2 = Baan.create(name: 'บ้าน 4', account_id: a.id)
b2 = Baan.create(name: 'บ้าน 5', account_id: a.id)
w1 = Wong.create(name: 'กลม1',baan_id: b1.id, wong_type: 'บิทดอกตาม', 
                fee_type: 'จ่ายงวดแรก', deposite: 35000, people: 35, 
                interest:1000,fee: 800, period: 7,start_date:Date.today,
                play_cycle: 30, paid: 0, income: 0
                )
w2 = Wong.create(name: 'กลม2',baan_id: b2.id, wong_type: 'บิทลดต้น', 
                fee_type: 'จ่ายงวดแรก', deposite: 35000, people: 35, 
                interest:1000,fee: 800, period: 30,start_date:Date.today,
                play_cycle: 30, paid: 0, income: 0
                )
w3 = Wong.create(name: 'กลม3',baan_id: b1.id, wong_type: 'ขั้นบันได', 
                fee_type: 'จ่ายงวดแรก', deposite: 35000, people: 35, 
                interest:800,fee: 800, period: 7,start_date:Date.parse('2021-11-28'),
                play_cycle: 30, paid: 6000
                )
w4 = Wong.create(name: 'กลม4',baan_id: b2.id, wong_type: 'ดอกตาม', 
                fee_type: 'จ่ายงวดแรก', deposite: 35000, people: 35, 
                interest:1000,fee: 800, period: 30,start_date:Date.parse('2021-11-15'),
                play_cycle: 30, paid: 8*1000, income: 10000
                )
s = Summary.create(wong_id: w3.id, created: Date.current)