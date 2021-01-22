class TagsController < ApplicationController

    before_action :set_tag, only: [:show, :update, :destroy]

    def index
        @tags = Tag.all()
    end

    def create
        @tag = Tag.new(tag_params)
        if @tag.save
            byebug
            render json: @tag, status: :created
        else
            render json: @tag.errors, status: :unprocessable_entity
        end
    end


    def show 
        render json: @tag
    end


    def update
        if @tag.update(tag_params)
            render json: @tag, status: :ok
        else
            render json: @tag.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @tag.destroy
        head :no_content
    end

    private

    def tag_params
        params.require(:tag).permit(:name)
    end

    def set_tag
        @tag = Tag.find(params[:id])
    end

end
