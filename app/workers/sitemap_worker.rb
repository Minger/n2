require 'aws/s3'

class SitemapWorker
  extend Resque::Plugins::Retry

  @queue = :sitemaps

  @retry_limit = 0
  @retry_exceptions = []


  def self.perform()
    SitemapGenerator::Sitemap.verbose = false
    SitemapGenerator::Sitemap.create
    self.upload_sitemaps_to_s3
    SitemapGenerator::Sitemap.ping_search_engines  
  end

  def self.upload_sitemaps_to_s3
    if File.exist?(File.join(Rails.root, "config", "s3.yml"))
      # Load credentials
      s3_options = YAML.load_file(File.join(Rails.root, "config", "s3.yml"))[Rails.env].symbolize_keys
      bucket = s3_options[:bucket]
      s3_options.delete(:bucket)
      
      # Establish S3 connection
      AWS::S3::Base.establish_connection!(s3_options)
      
      ["sitemap1.xml.gz", "sitemap_index.xml.gz"].each do |file_name|
        path = "/sitemaps/#{file_name}"
        file = File.new(File.join(Rails.root, "public", "system", "sitemaps", file_name))
        begin
          AWS::S3::S3Object.store(path, file, bucket, :access => :public_read)
          
        rescue AWS::S3::NoSuchBucket => e
          AWS::S3::Bucket.create(bucket)
          retry
        rescue AWS::S3::ResponseError => e
          raise
        end
        puts "Saved #{file_name} to S3"
      end
    end
  end

end
