class ChangeForeignKeysInComments < ActiveRecord::Migration[7.0]
  def change
    change_column_null :comments, :user_id, true
    change_column_null :comments, :post_id, true
  end
end
