class TidBitTagsController < ApplicationController
  before_action :find_project
  before_action :authorize

  def index
    @tags = TidBitTag.all
  end

  def new
    @tag = TidBitTag.new
  end

  def create
    @tag = TidBitTag.new(tag_params)
    if @tag.save
      flash[:notice] = l(:notice_successful_create)
      redirect_to project_settings_tid_bit_tags_path(@project)
    else
      render :new
    end
  end

  def edit
    @tag = TidBitTag.find(params[:id])
  end

  def update
    @tag = TidBitTag.find(params[:id])
    if @tag.update(tag_params)
      flash[:notice] = l(:notice_successful_update)
      redirect_to project_settings_tid_bit_tags_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @tag = TidBitTag.find(params[:id])
    @tag.destroy
    flash[:notice] = l(:notice_successful_delete)
    redirect_to project_settings_tid_bit_tags_path(@project)
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def tag_params
    params.require(:tid_bit_tag).permit(:name, :color)
  end
end