class UploadersController < ApplicationController
  def new
  end

  def create
    uploaded_file = params[:file]
    if uploaded_file
      gross = Uploader.import_and_calculate_gross(uploaded_file.read)
      if gross
        redirect_to uploaders_path(gross: gross), notice: "File successfully imported."
      else
        redirect_to uploaders_path, alert: "Invalid file. Choose another."
      end
    else
      redirect_to new_uploader_path, alert: 'You need to choose a file'
    end
  end

  def index
  end
end
