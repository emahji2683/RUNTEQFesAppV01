class ApplicationController < ActionController::Base

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include SessionsHelper

  def repeat_string(str, times)
    if str.present? && times.present?
    # 指定された回数だけ文字列を繰り返し結合して返す
      str * times
    end
  end

  def split_string(str, chunk_size)
    str.chars.each_slice(chunk_size).map(&:join)
  end
  
  def repeat_string_forsound(str)
    if str.present?
      str * 100
    end
  end
end
