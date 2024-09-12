class ContentListsController < ApplicationController
  before_action :set_content_list, only: %i[show edit update destroy]
  before_action :require_user, except: [ :new, :create ]
  before_action :require_same_user, only: [ :edit, :update, :destroy ]

  # GET /content_lists or /content_lists.json
  def index
    @content_lists = ContentList.all.limit(6)
    @switch = true
  end

  def show_all
    @content_lists = ContentList.all
    @switch = true
    render turbo_stream: [
      turbo_stream.replace("tab-content", partial: "shared/board", locals: { content_lists: @content_lists }),
      turbo_stream.replace("toggle-button-frame", partial: "shared/toggle_button", locals: { show_more: false, switch: true })
    ]
  end

  def user_six
    @content_lists = ContentList.where(user: current_user)
    render turbo_stream: [
      turbo_stream.replace("tab-content", partial: "shared/board", locals: { content_lists: @content_lists }),
      turbo_stream.replace("toggle-button-frame", partial: "shared/toggle_button", locals: { show_more: true, switch: false })
    ]
  end

  def user_all
    @content_lists = ContentList.where(user: current_user)


    render turbo_stream: [
      turbo_stream.replace("tab-content", partial: "shared/board", locals: { content_lists: @content_lists }),
      turbo_stream.replace("toggle-button-frame", partial: "shared/toggle_button", locals: { show_more: false, switch: false })
    ]
  end


  # GET /content_lists/1 or /content_lists/1.json
  def show
    repeat_content = @content_list.repeat_content
    repeat_times = @content_list.repeat_times

    # 生成した文字列
    long_string = repeat_string(repeat_content, repeat_times)

    # 改行位置でチャンクを分割するメソッドを使う
    chunk_size = 10_000 # チャンクサイズ
    @chunks = split_string_by_newline(long_string, chunk_size)

    @repeat_string_forsound = repeat_string_forsound(repeat_content)
    @repeat_string = repeat_string(repeat_content, repeat_times)
  end

  # 改行位置で文字列を分割するメソッド
  def split_string_by_newline(string, max_chunk_size)
    chunks = []
    current_chunk = ""

    string.each_line do |line|
      # 現在のチャンクに新しい行を追加してもサイズが許容されるか確認
      if (current_chunk.size + line.size) > max_chunk_size
        chunks << current_chunk
        current_chunk = line # 新しいチャンクを開始
      else
        current_chunk += line
      end
    end

    # 最後のチャンクを追加
    chunks << current_chunk unless current_chunk.empty?

    chunks
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
        flash[:notice] = t("notice.create")
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
        flash[:notice] = t("notice.update")
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
      flash[:notice] = t("notice.destroy")
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
      flash[:notice] = "ご自身の投稿のみ編集、削除できます。"
      redirect_to content_lists_url
    end
  end
end
