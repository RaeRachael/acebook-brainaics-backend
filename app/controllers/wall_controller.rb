class WallController < ApplicationController

  def new
    @wall_id = params[:id]
    @post = Post.new
    @user_id = current_user.id
    # create view with form for @posts - leads to Post at '/posts'
  end

  def show
    @current_user = current_user
    @user_wall = User.find(params[:id])
    @posts = Post.where("wall_id = ?", params[:id]).sort_by{ |post| post[:created_at] }.reverse
    data = { "posts" => @posts }
    render json: data
  end

  def index
    @posts = Post.all.sort_by{ |post| post[:created_at] }.reverse
    data = { "posts" => @posts }
    render json: data
  end
  
end
