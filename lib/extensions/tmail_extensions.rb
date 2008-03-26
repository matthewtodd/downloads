module TMail
  class Mail
    def strip_attachments
      returning self do
        parts.reject! { |part| attachment?(part) } if multipart?
      end
    end
    
    def send_to(recipient, via)
      
    end
  end
end