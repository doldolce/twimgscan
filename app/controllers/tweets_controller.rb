class TweetsController < ApplicationController
    def search
        client = Twitter::REST::Client.new do |config|
          # キーセット
          config.consumer_key         = ENV['TWITTER_CONSUMER_KEY']
          config.consumer_secret      = ENV['TWITTER_CONSUMER_SECRET']
        end
        @tweets = []
        since_id = nil
        # 検索ワードが存在していたらツイートを取得
        if params[:keyword].present?
          if params[:lastId].blank?
            # リツイートを除く、検索ワードにひっかかった最新100件のツイートを取得する
            tweets = client.search(params[:keyword], count: 100, result_type: "recent", exclude: "retweets", since_id: since_id, include_entities: "true", filter:"images")
          else
            # もっと画像を見るボタン押下時、現在のツイートid未満が検索対象になる
            next_page_id = params[:lastId].to_i - 1
            tweets = client.search(params[:keyword], count: 100, result_type: "recent", exclude: "retweets", include_entities: "true", filter:"images", max_id: next_page_id)
          end
          # 取得したツイートをモデルに渡す
          tweets.take(100).each do |tw|
            
            # 画像付きツイート(動画も含む)のみを対象とする
            if tw.media.first.try(:media_url).present?
              # 投稿時間をJSTに変換
              created_at = tw.created_at.in_time_zone('Tokyo').to_s
              # 「YY年MM月DD日 hh時mm分」の形にする
              time_parsed = created_at[0,4]+'年'+created_at[5,2]+'月'+created_at[8,2]+'日 '+created_at[11,2]+'時'+created_at[14,2]+'分'
              tweet = Tweet.new(tw.id, tw.full_text, tw.user.name, tw.user.screen_name, tw.retweet_count, tw.favorite_count, tw.media.first.url, tw.media.first.media_url, time_parsed, params[:keyword])
              @tweets << tweet
            end
          end
        end
        
        respond_to do |format|
          format.html
          format.json { render json: @tweets }
          format.js { render js: @tweets }
        end
    end
end
