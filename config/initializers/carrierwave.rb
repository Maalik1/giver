if Rails.env.development?

	CarrierWave.configure do |config|
	  config.storage = :file
	end

elsif Rails.env.test?

	CarrierWave.configure do |config|
	  config.storage = :file
	  config.enable_processing = false
	end

elsif Rails.env.production?
  
  # Simple local storage of uploaded images
	CarrierWave.configure do |config|
	  config.storage = :file
	end


  # To store uploaded images on Amazon S3
  # comment out the CarrierWave.configure above
  # and uncomment the settings below. Then add
  # your S3 credentials and bucket name.


	# CarrierWave.configure do |config|
	#   config.cache_dir = "#{Rails.root}/tmp/uploads"
	#   config.storage = :fog
	#   config.fog_credentials = {
	#     provider:              'AWS',
	#     aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
	#     aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
	#   }
	#   config.fog_directory = ENV['S3_BUCKET_NAME']
	# end

end