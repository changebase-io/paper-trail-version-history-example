# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit

  def home
    redirect_to posts_path
  end

  private

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end
end
