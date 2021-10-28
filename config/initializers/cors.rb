Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # 許可するドメイン
    origins 'localhost:3001'
    # 許可するヘッダーとメソッド
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end