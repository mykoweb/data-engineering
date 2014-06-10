class UploadersController < ApplicationController
  def new
  end

  def create
    uploaded_file = params[:file]
    if uploaded_file
      Uploader.import(uploaded_file.read)
      redirect_to uploaders_path, notice: "File successfully imported."
    else
      redirect_to new_uploader_path, alert: 'You need to choose a file'
    end
  end

  def index
  end
end
