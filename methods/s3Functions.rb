require 'aws-sdk-s3'  # v2: require 'aws-sdk'
load './local_env.rb' if File.exist?('./local_env.rb')

Aws.config.update({
    credentials: Aws::Credentials.new(ENV['access_key_id'], ENV['secret_access_key'])
 })

def upload_to_s3(image)
    s3 = Aws::S3::Resource.new(region: 'us-east-1')

    file = image
    bucket = 'wendys3storage'
        
    # Get just the file name
    name = File.basename(file)

    # Create the object to upload
    obj = s3.bucket(bucket).object(name)

    # Upload it      
    obj.upload_file(file)
end

require 'aws-sdk'
require 'fileutils'

def listResults
    # Aws.config.update(
    #     credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'] , ENV['AWS_SECRET_ACCESS_KEY'] ),
    #     region: 'us-east-1',
    #   )
    s3 = Aws::S3::Resource.new(region: 'us-east-1')
    
    bucket = s3.bucket("wendys3storage")

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
#     #     # key = key.gsub("8474/","").gsub("__","/")
#     #     puts "the key for downlaoading #{key}"
#     #     obj = s3.bucket('wendys3storage').object(key)
#     #     # dirname = File.dirname("./#{key}")
#     #     # unless File.directory?(dirname)
#     #     #     FileUtils.mkdir_p(dirname)
#     #     # end
#     #     return 
#     #     # Get the item's content and save it to a file
#     #     # obj.get(response_target: key.gsub('/','__'))
#     # end
# end




# listResults()
