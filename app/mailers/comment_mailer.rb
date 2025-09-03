class CommentMailer < ApplicationMailer
  default from: 'no-reply@yourapp.com'
  
  def notify_post_owner(comment)
    @comment = comment
    @post = comment.post
    @user = @post.user

    mail(
      to: @user.email,
      subject: "New comment on your post: #{@post.title}"
    )
  end
end
