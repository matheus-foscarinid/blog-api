class CommentsController < ApplicationController

    before_action :set_post, only: [:index, :create]
    before_action :set_comment, only: [:show, :update, :destroy]

    #  GET /posts/:post_id/comments
    def index
        @comments = @post.comments
        render json: @comments
    end

    # GET /posts/:post_id/comments/:id
    def show
        render json: @comment
    end

    # POST /posts/:post_id/comments
    def create
        @comment = @post.comments.new(comment_params)
        if @comment.save
            render json: @comment, status: :created
        else
            render json: @comment.errors, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /posts/:post_id/comment/:id
    def update
        if @comment.update(comment_params)
            render json: @comment, status: :ok
        else
            render json: @comment.errors, status: :unprocessable_entity
        end
    end

    # DELETE /posts/:post_id/comment/:id
    def destroy
        @comment.destroy
        head :no_content
    end

    private 

    def comment_params
        params.require(:comment).permit(:text)
    end

    def set_post
        @post = Post.find(params[:post_id])
    end

    def set_comment
        @comment = Comment.find(params[:id])
    end

end