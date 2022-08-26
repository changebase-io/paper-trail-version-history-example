# frozen_string_literal: true

module PaperTrail
  class Version < ::ActiveRecord::Base
    belongs_to :user, foreign_key: :whodunnit, optional: true
  end
end
