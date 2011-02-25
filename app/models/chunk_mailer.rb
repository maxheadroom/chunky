class ChunkMailer < ActionMailer::Base
  

  def send_link(chunk)
    @subject    = "Your download link for #{chunk.client}"
    @recipients = chunk.author
    @from       = "chunky@#{BASE_URL}"
    @sent_on    = Time.now
    
    @body["chunk"]  = chunk
  end

  def notify_client(chunk)
    @subject    = 'You got a Download from I-D Media AG'
    @recipients = chunk.client_email
    @from       = chunk.author
    @sent_on    = Time.now
    
    @body["chunk"] = chunk
  end

end
