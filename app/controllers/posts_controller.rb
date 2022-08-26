# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all.order(published_at: :desc)
  end

  def new
    @post = Post.new
  end

  def show; end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Post was deleted successfully.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user, :published_at)
  end

  def set_post
    @post = Post.find(params[:id])
    not_found unless @post
  end
end
