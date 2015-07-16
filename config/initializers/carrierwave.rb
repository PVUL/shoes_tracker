CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS', # required
    aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"], # required
    aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"], # required
    # region: ENV["AWS_REGION"], # optional, defaults to 'us-east-1'
    # host: 's3.example.com', # optional, defaults to nil
    # endpoint: 'https://s3.example.com:8080' # optional, defaults to nil
  }
  config.fog_directory = ENV["S3_BUCKET"] # required

  # config.storage    = :aws
  # config.aws_bucket = ENV.fetch('S3_BUCKET')
  # config.aws_acl    = 'public-read'

  # Optionally define an asset host for configurations that are fronted by a
  # content host, such as CloudFront.
  # config.asset_host = 'http://example.com'

  # The maximum period for authenticated_urls is only 7 days.
  # config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7

  # Set custom options such as cache control to leverage browser caching
  # config.aws_attributes = {
  #   expires: 1.week.from_now.httpdate,
  #   cache_control: 'max-age=604800'
  # }

  # config.aws_credentials = {
  #   access_key_id:     ENV.fetch('AWS_ACCESS_KEY_ID'),
  #   secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
  #   region:            ENV.fetch('AWS_REGION') # Required
  # }
end
