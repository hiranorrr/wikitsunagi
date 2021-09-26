require "net/http"
require 'json'
require 'nokogiri'
require 'open-uri'

class PostsController < ApplicationController
  # 問題の生成
  def make_question
    render json: get_titles_from_kujirahand
  end

  # 複数のWikipediaのランダムなタイトルを取得
  def get_titles_from_wiki(num=50)
    uri = URI("https://ja.wikipedia.org/w/api.php?")
    params = {  format: 'json',
                action: 'query',
                list: 'random',
                rnnamespace: 0,
                rnlimit: num
    }
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(uri)

    body = response.body
    body_hash = JSON.parse(body)

    titles = {}
    index = 0
    body_hash['query']['random'].each do |elm|
      titles["title#{index}"] = elm["title"]
      index += 1
    end

    return titles.to_json
  end

  # くじらはんどのAPIを利用し, タイトルを取得
  def get_titles_from_kujirahand
    # 対象のURL
    url = "https://kujirahand.com/web-tools/words/api.php?m=random"

    # # NokogiriでURLの情報を取得する
    contents = Nokogiri::HTML.parse(URI.open(url),nil,"utf-8")

    titles = {}
    index = 0
    contents.css('a').each do |link|
      if exist?(link.content)
        titles["title#{index}"] = link.content
        index += 1
      end
    end

    return titles.to_json
  end

  # 生成した単語がWikipediaに存在するか確認
  def exist?(word)
    uri = URI("https://ja.wikipedia.org/w/api.php?")
    params = {
        format: 'json',
        action: 'query',
        list: 'search',
        srsearch: word
    }
    uri.query = URI.encode_www_form(params)

    response = Net::HTTP.get_response(uri)

    body = response.body
    body_hash = JSON.parse(body)

    # 検索にかからなかった時の処理
    if body_hash['query']['search'] == []
      return false
    end

    return body_hash['query']['search'][0]['title'] == word
  end

  # Weblioからデータを取得し, DBに保存
  def scraping
    category = params[:category]
    date = params[:date]

    # 時間の指定がない時に現在の日時を取得
    if date.nil?
      t = Time.now
      date = t.strftime("%Y%m%d")
    end

    if category.nil?
      category_list = ['computer', 'engineering', 'academic','culture', 'healthcare', 'hobby', 'sports', 'nature', 'food', 'people']
      category_list.each do |category|
        subscraping(category, date)
      end
    else
      subscraping(category, date)
    end
  end

  # categoryとdateを指定して, データを取得保存
  def subscraping(category, date)
    # weblioのランキングのURL
    url = "https://www.weblio.jp/ranking/#{category}/#{date}"

    # データの取得, 保存
    contents = Nokogiri::HTML.parse(URI.open(url),nil,"utf-8")
    ranking = contents.at("table.mainRankCC")
    ranking_table = ranking.search("tr")
    ranking_table.each do |text|
      title = text.at_css('a')[:title]
      if exist?(title)
        post = Post.new(content: title, category: category, date: str2date(date))
        post.save
      end
    end
  end

  # stringをdate型に変換
  def str2date(date)
    return date[0,4] + '-' + date[4,2] + '-' + date[6,2]
  end

  # DBの指定したカラム名を取得
  def get_column_name
    name = params[:name]
    column = Post.select(name).distinct
    column_list = []
    column.each do |c|
      column_list.push(c[name.to_sym])
    end
    result = {result: column_list}
    render json: result.to_json
  end

  # データベースのデータを取得
  def get_db
    category = params[:category]
    date = params[:date]
    num = params[:num]
    data = Post.where(category: category, date: date).order("RAND()").limit(num)
    words = []
    data.each do |d|
      words.push(d.content)
    end
    word = {category: category, contents: words}
    render json: word.to_json
  end

end
