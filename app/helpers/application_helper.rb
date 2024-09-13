module ApplicationHelper
  def default_meta_tags
    {
      site: 'ゴリゴリテキスト屋さん',
      title: 'お言葉繰り返しサービス',
      reverse: true,
      charset: 'utf-8',
      description: 'ゴリゴリテキスト屋さんでテキストを作ろう',
      keywords: 'ゴリラ',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('goricard.png'), # 配置するパスやファイル名によって変更すること
        local: 'ja-JP'
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        card: 'summary_large_image', # Twitterで表示する場合は大きいカードにする
        site: '@', # アプリの公式Twitterアカウントがあれば、アカウント名を書く
        image: image_url('goricard.png') # 配置するパスやファイル名によって変更すること
      }
    }
  end
end
