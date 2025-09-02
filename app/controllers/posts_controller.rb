class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user! , only: %i[ new update destroy ]
  # GET /posts or /posts.json
  def index
    @posts = Post.all

    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    redirect_to posts_path,alert: "Not Authorized!" unless @post.user == current_user
  end

  def myposts
    if current_user
    @posts= Post.where(user_id: current_user.id)
    else 
      redirect_to root_path
    end
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    if @post.user != current_user
      redirect_to posts_path, alert: "Not Authorized"
      return
    end
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    if @post.user != current_user
      redirect_to posts_path, alert: "Not Authorized"
      return
    end
    @post.destroy!
    respond_to do |format|
      format.html { redirect_to posts_path, notice: "Post was successfully destroyed.", status: :see_other }
      format.json { head :no_content } 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body , :user_id)
    end
end
