class CreateWongs < ActiveRecord::Migration[6.1]
  def change
    create_table :wongs do |t|
      t.string :name
      t.string :wong_type
      t.string :fee_type #ประเภทค่าดูแล
      t.integer :deposite #เงินต้น
      t.integer :income, default: 0 #ดอกจากมืออื่น ๆ
      t.integer :people #จำนวนมือ
      t.integer :interest #ดอกเบี้ย
      t.integer :paid, default: 0 #ยอดที่ชำระแล้ว
      t.integer :bit , default: 0
      t.integer :bit_at, default: nil
      t.integer :discount_tracking
      t.integer :fee #ค่าดูแล
      t.integer :play_cycle ,default: nil
      t.integer :period
      t.boolean :status, default: false
      t.date :start_date
      
      t.references :baan

      t.timestamps
    end
  end
end
