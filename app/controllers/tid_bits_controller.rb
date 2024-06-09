class TidBitsController < ApplicationController
  before_action :find_project
  before_action :authorize
  before_action :find_tid_bit, only: [:show, :edit, :update, :destroy]

  helper :sort
  include SortHelper

  def index
    sort_init 'id', 'desc'
    sort_update 'id' => "#{TidBit.table_name}.id",
                'subject' => "#{TidBit.table_name}.subject",
                'created_at' => "#{TidBit.table_name}.created_at",
                'user' => "#{User.table_name}.firstname"

    @tid_bits = @project.tid_bits.joins(:user).order(sort_clause)
    if params[:search].present?
      @tid_bits = @tid_bits.where("subject LIKE ?", "%#{params[:search]}%")
    end
    if params[:tag].present?
      @tid_bits = @tid_bits.joins(:tid_bit_tag).where(tid_bit_tags: { name: params[:tag] })
    end
    @tid_bits = @tid_bits.paginate(page: params[:page], per_page: 10)
  end

  def show
    @comment = TidbitComment.new
  end

  def new
    @tid_bit = TidBit.new
    @tid_bit.tid_bit_attachments.build
  end

  def create
    @tid_bit = TidBit.new(tid_bit_params)
    @tid_bit.project = @project
    @tid_bit.user = User.current
    if @tid_bit.save
      save_attachments
      redirect_to project_tid_bits_path(@project), notice: 'Tid-Bit was successfully created.'
    else
      render :new
    end
  end

  def edit
    @tid_bit.tid_bit_attachments.build if @tid_bit.tid_bit_attachments.empty?
  end

  def update
    @tid_bit.assign_attributes(tid_bit_params)
    if @tid_bit.save
      save_attachments
      redirect_to project_tid_bit_path(@project, @tid_bit), notice: 'Tid-Bit was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @tid_bit.destroy
    redirect_to project_tid_bits_path(@project), notice: 'Tid-Bit was successfully deleted.'
  end

  def create_comment
    @tid_bit = TidBit.find(params[:tid_bit_id])
    @comment = @tid_bit.tidbit_comments.build(comment_params)
    @comment.user = User.current

    if @comment.save
      redirect_to project_tid_bit_path(@project, @tid_bit), notice: 'Comment was successfully added.'
    else
      render :show
    end
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_tid_bit
    @tid_bit = TidBit.find(params[:id])
  end

  def tid_bit_params
    params.require(:tid_bit).permit(:subject, :body, :tid_bit_tag_id, tid_bit_attachments_attributes: [:id, :file_name, :file_path, :_destroy])
  end

  def comment_params
    params.require(:tidbit_comment).permit(:content)
  end

  def save_attachments
    if params[:tid_bit][:attachments]
      params[:tid_bit][:attachments].each do |attachment|
        next if attachment.blank? || !attachment.respond_to?(:original_filename)

        TidBitAttachment.create(
          tid_bit: @tid_bit,
          file_name: attachment.original_filename,
          file_path: save_file(attachment)
        )
      end
    end
  end

  def save_file(file)
    directory = "public/uploads"
    path = File.join(directory, file.original_filename)
    File.open(path, "wb") { |f| f.write(file.read) }
    path
  end
end