class Tweet
  # プロパティの設定
  attr_accessor :id, :full_text, :account_name, :screen_name , :retweet_count, :favorite_count, :url, :media_url, :created_at, :query

  def initialize(id, full_text, account_name, screen_name, retweet_count, favorite_count, url, media_url, created_at, query)
    # ツイートのid
    @id = id
    # ツイート本文
    @full_text = full_text
    # ユーザ名
    @account_name = account_name
    # アカウントid
    @screen_name = screen_name
    # リツイート数
    @retweet_count = retweet_count
    # ファボ数
    @favorite_count = favorite_count
    # ツイートのURL
    @url = url
    # メディアURL
    @media_url = media_url
    # 投稿時間
    @created_at = created_at
    # 検索ワード
    @query = query
  end
end
