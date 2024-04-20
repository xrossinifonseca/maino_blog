class RemovePostReferenceFromTags < ActiveRecord::Migration[7.1]
  def change
    remove_reference :tags, :post, null: false, foreign_key: true
  end
end
