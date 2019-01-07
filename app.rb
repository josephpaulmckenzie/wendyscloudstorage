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

    s3upload = upload_to_s3(image["tempfile"])
    message = "Thanks For uploading a new image mom"
    images = listResults()

    erb :gallery, :locals => {images: images,message: message}


end



get '/gallery' do
    message = ""
    images = listResults()

    erb :gallery, :locals => {images: images,message: message}

end

post '/deletePhoto' do

    deleteimage = params[:deleteimage]

    puts deleteimage

end
