require 'test/unit'

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'downloads'

class TMailTest < Test::Unit::TestCase
  def setup
    @message = TMail::Mail.load(File.join(File.dirname(__FILE__), 'email_with_attachment.txt'))
    @attachments = @message.attachments
  end

  def test_attachments_size
    assert_equal 1, @attachments.size
  end

  def test_first_attachment_size
    assert_equal 12308, @attachments.first.size
  end

  def test_first_attachment_size_after_read_filename
    assert_equal 'matthewtodd.jpg', @attachments.first.original_filename
    assert_equal 12308, @attachments.first.size
  end
end