class Comment < ApplicationRecord
  has_rich_text :content
  belongs_to :post
  broadcasts_to :post

  # after_create_commit -> { broadcast_append_to post }
  after_create_commit -> { CheckForSpamJob.perform_later self }
  # after_update_commit -> { broadcast_replace_to post }
  # after_destroy_commit -> { broadcast_remove_to post }
end
