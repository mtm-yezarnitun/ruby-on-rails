class FixPostReferenceInComments < ActiveRecord::Migration[7.1]
def change
  remove_reference :comments, :posts, foreign_key: true
  add_reference :comments, :post, null: false, foreign_key: true
end
end
