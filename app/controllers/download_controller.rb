# require 'ruby-debug'

class DownloadController < ApplicationController
 layout :select_layout
  
  def download
    # debugger
    # @chunk = Chunk.new(params[:chunks])
    # puts "Download klasse: " + @chunk.inspect
    # send_file RAILS_ROOT + UPLOAD_DIR + "/" + Chunk.find(:first, :conditions => "link = '#{params[:id]}'").filename
    chunk = Chunk.first(:conditions => ['link = ?', params[:id]])

    if chunk 
      if DateTime.now.to_date > chunk.expire_date
        flash.now[:notice] = "I'm so sorry. Your download link has expired"
      else
        if chunk.download_count_max
          if chunk.download_count < chunk.download_count_max
            send_file File.join(Rails.root, UPLOAD_DIR, chunk.filename)
            chunk.increment! :download_count
          else
            flash.now[:notice] = "I'm so sorry but the max download count has been reached. You're not allowed to download this file anymore."
          end
        else
          send_file File.join(Rails.root, UPLOAD_DIR, chunk.filename)
          chunk.increment! :download_count
        end
      end
    else
      flash.now[:notice] = "I'm so sorry. Your download link has expired"
    end
  end
  
  def index
    flash.now[:message] = "Hello!"
  end
  
private  
  def select_layout
      [ 'index'].include?(action_name) ? "index" : "standard"
    end
  
end
