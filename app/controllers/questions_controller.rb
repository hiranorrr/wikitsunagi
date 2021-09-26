# サイトにアクセスしgem
require 'open-uri'

# スクレイピングのgem
require 'nokogiri'

# CSV出力するClass
require 'csv'

require "net/http"


class QuestionsController < ApplicationController
    def get_next_link_lst(now_link)
        uri = URI("https://ja.wikipedia.org/w/api.php?")
        params = {  format: 'json',
                    action: 'parse',
                    prop: 'links',
                    page: now_link
        }
        uri.query = URI.encode_www_form(params)
        response = Net::HTTP.get_response(uri)
        
        body = response.body
        body_hash = JSON.parse(body)

        link_lst = []
        now = body_hash['parse']['title']
        body_hash['parse']['links'].each do |element|
            if element['ns'] == 0
                link_lst.push(element['*'])
            end
        end

        return link_lst
    end

    def verify_answer(answer=['ジョジョの奇妙な冒険', 'ジョン・レノン', '1955年', '上沼恵美子'])
        result = false
        (1..answer.length).each do |i|
            ans = answer[i-1]
            next_link_lst = get_next_link_lst(ans)
            
            if not next_link_lst.include?(ans)
                break
            end

            puts i
            puts next_link_lst.include?(ans)

            if i == answer.length
                result = true
            end
        end
        # render json: {items: result}
        # render json: {items: get_nex t_link_lst('ジョジョの奇妙な冒険')}
    end

end
