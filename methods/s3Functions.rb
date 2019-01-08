require 'aws-sdk-s3'  # v2: require 'aws-sdk'
require 'aws-sdk'
require 'fileutils'

load './local_env.rb' if File.exist?('./local_env.rb')

  Aws.config.update(
        credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'] , ENV['AWS_SECRET_ACCESS_KEY'] ),
        region: 'us-east-1',
      )

def upload_to_s3(file)
    s3 = Aws::S3::Resource.new(region: 'us-east-1')  
    bucket = ENV['S3BUCKET']
        
    # Get just the file name
    name = File.basename(file)

    # Create the object to upload
    obj = s3.bucket(bucket).object(name)

    # Upload it      
    obj.upload_file(file)
end



def listResults
  
    s3 = Aws::S3::Resource.new(region: 'us-east-1')
    
    bucket = s3.bucket(ENV['S3BUCKET'])

        keys = []
    bucket.objects.each do |item|
        searchresult = item.key.split("/")[0]
        keys.push("https://s3.amazonaws.com/wendys3storage/#{item.key}")

    puts "Search Result: #{searchresult}"
    puts "Name:  #{item.key}"
    puts "THE WHOLE ITEM: #{item}"
end

puts "KEYS ARE #{keys}"
# downloadResults(keys)
return keys
end

# # def downloadResults(keys)

#     s3 = Aws::S3::Resource.new(region: 'us-east-1')
#     puts keys
#     # keys.each do |key|
#     #     puts "the key for downlaoading #{key}"
#     #     obj = s3.bucket('wendys3storage').object(key)
#     #     # dirname = File.dirname("./#{key}")
#     #     # Will check if directory exsits to save to if not creates the directory 
#     #     # unless File.directory?(dirname)
#     #     #     FileUtils.mkdir_p(dirname)
#     #     # end
#     #     return 
#     #     # Get the item's content and save it to a file
#     #     # obj.get(response_target: key)
#     # end
# end

    def delete_photo_from_s3(file)

        file = file.split("/")[-1]
        s3 = Aws::S3::Resource.new(region: 'us-east-1')
        s3.bucket(ENV['S3BUCKET']).object(file).delete   
    end

# listResults()
