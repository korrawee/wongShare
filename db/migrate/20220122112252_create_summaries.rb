class CreateSummaries < ActiveRecord::Migration[6.1]
  def change
    create_table :summaries do |t|
      t.integer :income, default: 0
      t.integer :outcome, default: 0
      t.integer :result, default: 0
      t.date :created, :unique =>  true

      t.references :account
      t.timestamps
    end
  end
end
