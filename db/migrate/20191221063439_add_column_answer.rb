class AddColumnAnswer < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :is_best, :boolean ,default: false, null: false
  end
end
