# frozen_string_literal: true

class Post < ApplicationRecord
  attr_accessor :fields_changed

  has_paper_trail({
                    versions: { scope: -> { order(id: :desc) } },
                    meta: {
                      # fields_changed: proc { |post| post.changed.reject { |x| x == 'updated_at' } },
                      fields_changed: :fields_changed,
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

  before_save :set_fields_changed

  def set_fields_changed
    @fields_changed = changed.reject { |x| x == 'updated_at' }
  end
end
