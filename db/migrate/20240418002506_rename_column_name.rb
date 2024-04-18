class RenameColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :posts, :customer_id, :author_id
  end
end
