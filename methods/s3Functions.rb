require 'aws-sdk-s3'  # v2: require 'aws-sdk'
require 'aws-sdk'
require 'fileutils'

load './local_env.rb' if File.exist?('./local_env.rb')

#   Aws.config.update(
#         credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'] , ENV['AWS_SECRET_ACCESS_KEY'] ),
#         region: 'us-east-1',
#       )

def upload_to_s3(folder,file)
    s3 = Aws::S3::Resource.new(region: 'us-east-1')  
    bucket = "wendys3storage"
        
    # Get just the file name
    name = File.basename(file)

    # Create the object to upload
    obj = s3.bucket(bucket).object("#{folder}/#{name}")

    # Upload it      
    obj.upload_file(file)
end

def listFolders()
    s3 = Aws::S3::Resource.new(region: 'us-east-1')

    bucket = s3.bucket('wendys3storage')

        folders = []
        bucket.objects.each do |item|
        searchresult = item.key.split("/")[0]
        folders.push(searchresult)
end

p folders.uniq
return folders.uniq

end



def listResults(searchterm)
    # keys = []
    s3 = Aws::S3::Resource.new(region: 'us-east-1')

    bucket = s3.bucket('wendys3storage')

        keys = []
        bucket.objects.each do |item|
        searchresult = item.key.split("/")[0]
    if searchresult == searchterm
        keys.push("https://s3.amazonaws.com/wendys3storage/#{item.key}")
    elsif searchterm == "None"
        keys.push("https://s3.amazonaws.com/wendys3storage/#{item.key}")
    end
  
    # puts "Search Result: #{searchresult}"
    # puts "Name:  #{item.key}"
    # puts "THE WHOLE ITEM: #{item}"
end
return keys

end


# listResults("AnimalPics")
# listFolders()
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
