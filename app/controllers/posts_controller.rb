class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:guest_view]

  def index
    @posts = Post.all.order('created_at desc')
    @posts_count = current_user.posts.length

  end
  
  def create
   #temp_post = Post.new
    #temp_post.user_id = current_user.id
    #temp_post.content = params[:coutent]
    post = Post.new(user_id: current_user.id, content: params[:content])
    hashtags =params[:hashtags].split(',')
    hashtags.each do |tag|
      hashtag = Hashtag.find_or_create_by(name: tag.delete('#'))
      hashtag.save
      post.hashtags << hashtag
    end
   
    
    if post.save
      redirect_to root_path
    else
      redirect_to post_path
    end 
    

  end

  
  def show
  end
  
  def edit
    @posts=Post.all
    @post = Post.find_by(id: params[:id])
  end
  
  def update
  
    @post = Post.find_by(id: params[:id])
    redirect_to root_path if @post.user.id != current_user.id
    
    @post.hashtags = []
    @post.content = params[:content]
    @post.image =params[:image] if params[:image].present?
    
    hashtags = params[:hashtags].split(",")
     hashtags.each do |onetag|
      hashtag = Hashtag.find_or_create_by(name: onetag.delete('#'))
      hashtag.save
      @post.hashtags << hashtag
    end
    
    if @post.save
      redirect_to root_path
    else
      render :edit
    end
  end
  
  def new
  end
  
  def destroy
    post = Post.find_by(id: params[:id])
    if post.user_id != current_user.id
      redirect_to root_path 
    else
      post.destroy
      redirect_to root_path 
    end
  end
  
  def guest_view
    @posts = Post.all.order('created_at desc')
  end
  
  
end

