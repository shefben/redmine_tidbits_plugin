class TidbitCommentsController < ApplicationController
  before_action :find_project
  before_action :find_tid_bit

  def create
    @comment = @tid_bit.tidbit_comments.build(comment_params)
    @comment.user = User.current
    if @comment.save
      redirect_to project_tid_bit_path(@project, @tid_bit), notice: 'Comment added.'
    else
      render 'tid_bits/show'
    end
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_tid_bit
    @tid_bit = TidBit.find(params[:tid_bit_id])
  end

  def comment_params
    params.require(:tidbit_comment).permit(:content)
  end
end