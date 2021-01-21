class PostsController < ApplicationController

    before_action :set_post, only: [:show, :update, :destroy]

    def index
        @posts = Post.all()
        respond_to do |format|
            format.html { render :index}
            format.json { render json: @posts}
        end
    end

    def create
        @post = Post.new(post_params)
        if @post.save
            render json: @post, status: :created
        else
            render json: @post.errors, status: :unprocessable_entity
        end
    end


    def show 
        render json: @post
    end


    def update
        if @post.update(post_params)
            render json: @post, status: :ok
        else
            render json: @post.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @post.destroy
        head :no_content
    end

    private

    def post_params
        params.require(:post).permit(:title, :description)
    end

    def set_post
        @post = Post.find(params[:id])
    end

    def render_not_found(exception)
        render json: {error: exception.message}, status: :expectation_failed
    end

    def render_parameter_missing(exception)
        render json: {error: exception.message}, status: :expectation_failed
    end
end
