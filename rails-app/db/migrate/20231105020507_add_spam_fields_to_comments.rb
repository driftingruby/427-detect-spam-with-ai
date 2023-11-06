class AddSpamFieldsToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :spam, :boolean, default: false
    add_column :comments, :spam_checked_on, :datetime
  end
end
