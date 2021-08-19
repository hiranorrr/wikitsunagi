FROM ruby:2.7.4

# 作業ディレクトリを/rails6_api_mysql8に指定
WORKDIR /wikitsunagi

# ローカルのGemfileをDokcerにコピー
COPY Gemfile* /wikitsunagi/

# /rails6_api_mysql8ディレクトリ上でbundle install
RUN bundle install
