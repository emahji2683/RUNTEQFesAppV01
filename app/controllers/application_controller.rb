class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  def repeat_string(str, times)
    if str.present? && times.present?
    # 指定された回数だけ文字列を繰り返し結合して返す
      str * times
    end
  end
end
