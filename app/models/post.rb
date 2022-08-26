# frozen_string_literal: true

class Post < ApplicationRecord
  has_paper_trail({
                    versions: { scope: -> { order(id: :desc) } },
                    meta: {
                      is_restorable: proc { |post| post.versions.first.present? },
                      originator_id: proc do |post|
                        version = post.versions.first
                        if version.blank?
                          nil
                        else
                          version.whodunnit
                        end
                      end
                    }
                  })

  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
end
