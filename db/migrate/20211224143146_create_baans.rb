class CreateBaans < ActiveRecord::Migration[6.1]
  def change
    create_table :baans do |t|
      t.string :name
      t.string :tel
      t.references :account
      t.timestamps
    end
  end
end
