class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_comment, only: [:destroy]
    include Pundit::Authorization


    def create 
        @post =Post.friendly.find(params[:post_id])
        @comment = @post.comments.build(comment_params)
        @comment.user = current_user
        
        if @comment.save 
            if @post.user != current_user
                Notification.create(
                recipient: @post.user,
                actor: current_user,
                action: 'commented',
                notifiable: @comment,
                read: false
                )
            CommentMailer.notify_post_owner(@comment).deliver_later
            end
            redirect_to @post, notice: "Comment Added!"
        else 
            redirect_to @post, alert:  "Comments Cannot be Blank !"
        end
    end
    def destroy
        authorize @comment
        if @comment.destroy
            redirect_to @comment.post, notice: "Comment deleted."
        else
            redirect_to @comment.post, alert: "You can't delete this comment."
        end
    end


    private

    
    def set_comment
        @comment = Comment.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:body)
    end
end
