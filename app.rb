require 'sinatra'
require_relative 'methods/s3Functions.rb'
load './local_env.rb' if File.exist?('./local_env.rb')

get '/' do
    message = ""
    images = listResults()
    erb :index, :locals => {message: message, images: images}

end

post '/login' do

username = params['username']
password = params['password']

    if username == ENV['username'] && password == ENV['password']
        redirect '/gallery'
    else
        "Sorry"
    end
end



post '/s3upload' do

    image = params[:image]
    searchterm = params[:searchterm]
    folderName = params[:folderName]
    s3upload = upload_to_s3(folderName,image["tempfile"])
    message = "Thanks For uploading a new image mom"
    # images = listResults(searchterm)
    redirect "/gallery?message=#{message}&searchterm=#{searchterm}"
    # erb :gallery, :locals => {images: images,message: message}


end



get '/gallery' do
    message = params[:message] || ""
    searchterm = params[:searchterm] || ""
    customFolder = params[:customFolder] || ""
    if searchterm != ""
        searchterm = searchterm
    elsif customFolder != ""
        searchterm = customFolder
    else 
        searchterm = "None"
    end
    p "The Search is #{searchterm}"
    images = listResults(searchterm)
    listFolders = listFolders()
    puts "THE MESSAGE IS #{message}"

    erb :gallery, :locals => {images: images,message: message,listFolders: listFolders,searchterm: searchterm}

end

post '/deletePhoto' do
    searchterm = params[:searchterm]
    imageToDelete = params[:imageToDelete]
    delete_photo_from_s3(searchterm,imageToDelete)
    redirect '/gallery?message=The Photos you selected has been deleted.'

end
