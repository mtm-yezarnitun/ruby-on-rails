class RemoveUsersIdFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :users_id, :integer
  end
end
