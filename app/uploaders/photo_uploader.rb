# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  process :auto_orient
  process :set_content_type
  process :resize_to_fit => [400, 400]

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.slug}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    'default/basic.jpg'
  end

  def auto_orient
    manipulate! do |image|
      image.tap(&:auto_orient)
    end
  end

  # Create different versions of your uploaded files:
  version :thumbnail do
    process :resize_to_fill => [50, 50]
  end

  version :large do
    process :resize_to_fit => [750, 750]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    mounted_as if original_filename
  end

end
