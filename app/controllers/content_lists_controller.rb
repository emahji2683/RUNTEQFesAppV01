class ContentListsController < ApplicationController
  before_action :set_content_list, only: %i[show edit update destroy]
  before_action :require_user, except: [:new, :create]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET /content_lists or /content_lists.json
  def index
    @content_lists = ContentList.all
  end

  def show_all
    @content_lists = ContentList.all
    render turbo_stream: [
      turbo_stream.replace('tab-content', partial: 'shared/board', locals: { content_lists: @content_lists }),
      turbo_stream.replace('toggle-button-frame', partial: 'shared/toggle_button', locals: { show_more: false })
    ]
  end

  # GET /content_lists/1 or /content_lists/1.json
  def show
      repeat_content = @content_list.repeat_content
      repeat_times = @content_list.repeat_times
      # 生成した文字列
      long_string = repeat_string(repeat_content, repeat_times)
      # チャンクサイズを設定
      chunk_size = 10_000 # 一度に処理する文字数
      # チャンクに分割
      @chunks = split_string(long_string, chunk_size)
      @repeat_string_forsound = repeat_string_forsound(repeat_content)
      @repeat_string = repeat_string(repeat_content, repeat_times)
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
    @content_list.user_id = current_user.id
    respond_to do |format|
      if @content_list.save
        flash[:notice] = t('notice.create')
        format.html { redirect_to content_list_url(@content_list) }
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
        flash[:notice] = t('notice.update')
        format.html { redirect_to content_list_url(@content_list) }
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
      flash[:notice] = t('notice.destroy')
      format.html { redirect_to content_lists_url }
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

  # ユーザーがコンテンツの作成者であることを確認
  def require_same_user
    if current_user.id != @content_list.user_id
      flash[:alert] = "許可されていない操作です。プロフィールの編集、削除は作成者ご自身のみ可能です。"
      redirect_to content_lists_url
    end
  end
end
