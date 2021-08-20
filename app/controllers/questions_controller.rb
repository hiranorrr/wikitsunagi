require "net/http"
require 'json'

class QuestionsController < ApplicationController
    # 問題の生成
    def make_question
        render json: {items: {title1: get_title, title2: get_title}}
    end

    # Wikipediaのランダムなタイトルを取得
    def get_title
        # MediaWiki APIを利用して, ランダムなwikiのサイトの情報を取得
        uri = URI.parse("https://ja.wikipedia.org/w/api.php?format=json&action=query&generator=random&grnnamespace=0&prop=info")
        response = Net::HTTP.get_response(uri)

        # サイト情報からタイトルを抽出
        body = response.body
        body_hash = JSON.parse(body)
        title = ""
        body_hash['query']['pages'].each do |k,v|
            title = v['title']
        end
        return title
    end
end
