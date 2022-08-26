# frozen_string_literal: true

module PaperTrail
  class Version < ::ActiveRecord::Base
    belongs_to :user, foreign_key: :whodunnit, optional: true
    belongs_to :originator, optional: true, class_name: 'User'
  end
end
