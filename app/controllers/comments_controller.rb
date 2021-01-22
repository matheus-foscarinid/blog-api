class CommentsController < ApplicationController
    
    before_action :authorized, except: [:show]
    before_action :set_post, only: [:index, :create]
    before_action :set_comment, only: [:show, :update, :destroy]

    #  GET /posts/:post_id/comments
    def index
        @comments = @post.comments
    end

    # GET /posts/:post_id/comments/:id
    def show
        render json: @comment
    end

    # POST /posts/:post_id/comments
    def create
        @comment = @post.comments.new(comment_params)
        @comment.user_id = @user.id
        if @comment.save
            render json: @comment, status: :created
        else
            render json: @comment.errors, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /posts/:post_id/comment/:id
    def update

        if is_owner?
            if @comment.update(comment_params)
                render json: @comment, status: :ok
            else
                render json: @comment.errors, status: :unprocessable_entity
            end
        else
            render json: {error: 'User not authorized'}, status: :unauthorized
        end
    end

    # DELETE /posts/:post_id/comment/:id
    def destroy
        if is_owner? || is_post_owner?
            @comment.destroy
            head :no_content
        else
            render json: {error: 'User not authorized'}, status: :unauthorized
        end
    end

    private 

    def comment_params
        params.require(:comment).permit(:text)
    end

    def set_post
        @post = Post.find(params[:post_id])
    end

    def is_owner?
        @comment.user_id = @user.id
    end

    def is_post_owner?
        post = @comment.post
        post.user_id == @user.id
    end

    def set_comment
        @comment = Comment.find(params[:id])
    end

end