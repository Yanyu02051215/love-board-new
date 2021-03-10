class Payment < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :account_id
      t.string :card_id
      t.string :customer_id
      t.string :payment_method_id

      t.timestamps
    end
  end
end
