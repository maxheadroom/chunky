require 'ftools'

class Uploadedfile < ActiveRecord::BaseWithoutTable
  
  
  def file= (fileobj)
    if fileobj.size > 0
      @file = fileobj
      puts "Bis hierhin ists gut gegangen: #{fileobj.class}\n"
      filename = unique_filename(fileobj.original_filename)
      save_uploaded_file(@file, filename)
    end
  end
  
  
  
  def self.filelist
    Dir[File.join(Rails.root, UPLOAD_DIR) + '**/*'].sort.map { |file| File.basename(file) }
  end
 

private

  def unique_filename(filename)
    if File.exist?(RAILS_ROOT + UPLOAD_DIR + "/" + filename)
      Time.now.to_i.to_s + "_" + File.basename(filename).gsub(/[^\w._-]/, '')
    else
      filename
    end
  end
  
  def save_uploaded_file(fileobj, filename)
      # complete path
      complete_path = RAILS_ROOT + UPLOAD_DIR

      unless File.exists?(complete_path)
        Dir.mkdir(complete_path)
      end
      # save iamge
      begin
        f = File.open(complete_path + "/" + filename, 'wb')
        f.write(fileobj.read)
        puts "Save to: #{complete_path}/#{filename} \n"
      rescue
        puts "Im Rescue-Teil \n"
        return false
      ensure
        f.close unless f.nil?
      end 
    end
  
end