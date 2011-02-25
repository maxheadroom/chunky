require 'digest/md5'
require 'ftools'

class Chunk < ActiveRecord::Base
  
  #email_regex = %r{\A[0-9a-z._\-\+]+@[0-9a-z.-]+\.[a-z]{2,4}\Z}xi # Case insensitive
  email_regex = %r{^[0-9a-z.+_-]+@[0-9a-z.-]+\.[a-z]{2,4}$}xi
 
   
     
  validates_presence_of :client, :client_email, :author, :expire_date, :filename
  validates_format_of  :client_email,
                      :with => email_regex,
                      :message => "Please enter a valid client mail address." 
  validates_format_of :author,
                      :with => email_regex,
                      :message => "Please enter a valid eMail address for your email."



  def validate
    errors.add(:expire_date, "The expire date must be today or in future.") if expire_date == nil || expire_date < DateTime.now - 1 
  end

  def set_link
    unique_string = Time.now.to_s + self.filename
    self.link = Digest::MD5.hexdigest(unique_string)
    create_symlink
  end
  
  def clean_up_database
    cleaner = Chunk.all
    cleaner.map { |c|
      puts "C-Objekt: #{c.class} and #{c.respond_to?("cleanup")}"
      c.cleanup
    }
    
  end
  
  def cleanup
    if File.exists?(File.join(RAILS_ROOT + UPLOAD_DIR, self.filename))
    else
      puts "This file doesn't exists and the record #{self.id} will be deleted: #{self.filename}\n"
      Chunk.delete(self.id)
    end
  end
  
private 
  def create_symlink
    begin
      # create a directory with the link name
      File.makedirs(RAILS_ROOT + "/public" + LINK_DIR + "/" + self.link)
      # now link the file directly into that dir.
      File.symlink(RAILS_ROOT + UPLOAD_DIR + "/" + self.filename, RAILS_ROOT + "/public" + LINK_DIR + "/" + self.link + "/" + self.filename) 
    rescue SystemCallError => e
      puts e.message
    end
  end
end
