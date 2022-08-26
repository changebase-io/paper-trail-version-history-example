# frozen_string_literal: true

class VersionsController < ApplicationController
  before_action :set_post
  before_action :set_versions, only: %i[index show]
  before_action :set_version, only: %i[show update]
  before_action :authenticate_user!

  def index
    redirect_to post_version_path(@post, @versions.first.id) if @versions.first
  end

  def show; end

  def update; end

  private

  def set_post
    @post = Post.find(params[:post_id])
    not_found unless @post
  end

  def set_versions
    @versions = @post.versions.includes(:user)
    not_found if @versions.empty?
  end

  def set_version
    @version = @post.versions.find(params[:id])
    not_found unless @version
  rescue StandardError
    not_found
  end
end
