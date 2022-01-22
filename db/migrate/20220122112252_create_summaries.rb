class CreateSummaries < ActiveRecord::Migration[6.1]
  def change
    create_table :summaries do |t|
      t.integer :income
      t.integer :outcome
      t.integer :result
      t.date :created
      t.references :wong
      t.timestamps
    end
  end
end
