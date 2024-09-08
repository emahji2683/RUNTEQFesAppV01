class ContentListsController < ApplicationController
  before_action :set_content_list, only: %i[ show edit update destroy ]

  # GET /content_lists or /content_lists.json
  def index
    @content_lists = ContentList.all
  end

  def show_all
    @content_lists = ContentList.all
    # 全コンテンツを表示し、ボタンを閉じるに変更
    render turbo_stream: [
      turbo_stream.replace('tab-content', partial: 'shared/board', locals: { content_lists: @content_lists }),
      turbo_stream.replace('toggle-button-frame', partial: 'shared/toggle_button', locals: { show_more: false })
    ]
  end

  

  # GET /content_lists/1 or /content_lists/1.json
  def show
    repeat_content = @content_list.repeat_content
    repeat_times = @content_list.repeat_times
    @repeat_string = repeat_string(repeat_content, repeat_times)
    @repeat_string_forsound = repeat_string_forsound(repeat_content)
  end

  # GET /content_lists/new
  def new
    @content_list = ContentList.new
  end

  # GET /content_lists/1/edit
  def edit
  end

  # POST /content_lists or /content_lists.json
  def create
    @content_list = ContentList.new(content_list_params)

    respond_to do |format|
      if @content_list.save
        format.html { redirect_to content_list_url(@content_list), notice: "Content list was successfully created." }
        format.json { render :show, status: :created, location: @content_list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @content_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /content_lists/1 or /content_lists/1.json
  def update
    respond_to do |format|
      if @content_list.update(content_list_params)
        format.html { redirect_to content_list_url(@content_list), notice: "Content list was successfully updated." }
        format.json { render :show, status: :ok, location: @content_list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @content_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /content_lists/1 or /content_lists/1.json
  def destroy
    @content_list.destroy!

    respond_to do |format|
      format.html { redirect_to content_lists_url, notice: "Content list was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content_list
      @content_list = ContentList.find(params[:id])
    end

    def content_list_params
      params.require(:content_list).permit(:title, :repeat_content, :repeat_times)
    end
    # Only allow a list of trusted parameters through.
end
