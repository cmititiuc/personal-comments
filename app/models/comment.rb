class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  before_save :clean_values

  default_scope -> { order('created_at DESC') }

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user

  validates :comment, :length=>{ minimum: 1 }
end

private
include ActionView::Helpers::SanitizeHelper
def clean_values
  self.comment = strip_tags(self.comment)
end