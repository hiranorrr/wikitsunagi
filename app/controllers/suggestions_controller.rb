require 'json'
require 'net/http'
require "uri"

class SuggestionsController < ApplicationController
    def show
        #from = "卑弥呼" 
        #to = "レッドブル"
        from = params[:from]
        to = params[:to]
        uri_before_encode = 'http://gohost:8000/api/suggestion/' + from + '/' + to
        uri = URI(URI.encode uri_before_encode)
        # uri = URI("http://192.168.2.117:8000/api/suggestion/Java/NASA")
        http = Net::HTTP.new(uri.host, uri.port)
        req = Net::HTTP::Get.new(uri)
        res = http.request(req)
        #res.bodyに模範解答のjsonが入ってる
        render json: res.body
    end
end
