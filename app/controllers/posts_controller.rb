class PostsController < ApplicationController
    before_action :authorized, except: [:index, :show]
    before_action :set_post, only: [:show, :update, :destroy, :link_tag, :unlink_tag]
    before_action :render_not_authorized_user, except: [:index, :show, :create]
    before_action :set_tag, only: [:link_tag, :unlink_tag]
    # GET /posts
    def index
        @posts = Post.all().order(updated_at: :desc)
    end

    # POST /posts
    def create
        @post = @user.posts.new(post_params)
        if @post.save
            render json: @post, status: :created
        else
            render json: @post.errors, status: :unprocessable_entity
        end
    end

    # GET /posts/:post_id
    def show
        @comments = Comment.where(post: @post.id).order(updated_at: :desc)
        @tags = @post.tags.order(:name)
    end

    # PUT/PATCH /posts/:id
    def update
        if @post.update(post_params)
            render json: @post, status: :ok
        else
            render json: @post.errors, status: :unprocessable_entity
        end
    end

    # DELETE /posts/:id/
    def destroy
        if is_authorized?
            @post.destroy
            render json: {message: "Post destroyed!"}, status: :ok
        else 
            render json: {message: @post.errors}, status: :access_denied
        end
    end

    # POST /posts/:id/tag
    def link_tag
        @post.tags.push(@tag)
        render json: @post.tags, status: :ok
    end

    # DELETE /posts/:id/tag
    def unlink_tag
        @post.tags.delete(@tag)
        head :no_content
        # render json: @post.tags, status: :ok
    end

    private

    def post_params
        params.require(:post).permit(:title, :description)
    end

    def is_authorized?
        @post.user = @user
    end

    def render_not_authorized_user
        unless is_authorized?
            render json: {error: 'User not authorized'}, status: :unauthorized
        end
    end

    def set_post
        @post = Post.find(params[:id])
    end

    def set_tag
        @tag = Tag.find(params[:post][:tag_id])
    end

    def render_not_found(exception)
        render json: {error: exception.message}, status: :expectation_failed
    end

    def render_parameter_missing(exception)
        render json: {error: exception.message}, status: :expectation_failed
    end
end
