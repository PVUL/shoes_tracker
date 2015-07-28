class ImageUploader < CarrierWave::Uploader::Base
  # Storage configuration within the uploader supercedes the global CarrierWave
  # config, so be sure that your uploader does not contain `storage :file`, or
  # AWS will not be used.
  include CarrierWave::RMagick

  if Rails.env.production? # || Rails.env.development?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fill: [250, 250]
  end

  version :small do
    process resize_to_fill: [150, 150]
  end

  version :list do
    process resize_to_fill: [250, 100]
  end

  version :calendar do
    process resize_to_fill: [75, 75]
  end

  # You can find full list of custom headers in AWS SDK documentation on
  # AWS::S3::S3Object
  # def download_url(filename)
  #   url(response_content_disposition: %Q{attachment; filename="#{filename}"})
  # end
end
