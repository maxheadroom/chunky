class Admin::UploadedfilesController < ApplicationController
  layout 'standard'
  
  def index
    @uploadfile = Uploadedfile.new
    @filelist = Uploadedfile.filelist
  end
  def upload
    
     @uploadfile = Uploadedfile.new(params[:uploadfile])
     @uploadfile.save!
      redirect_to(:action => :index)    
  end
end