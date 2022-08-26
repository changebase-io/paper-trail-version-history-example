# frozen_string_literal: true

class Post < ApplicationRecord
  has_paper_trail

  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
end
