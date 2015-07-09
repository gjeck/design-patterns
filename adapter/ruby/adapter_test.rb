require 'test/unit'
require_relative 'encrypter_adapter'

class AdapterTest < Test::Unit::TestCase
    def setup
        @content_file = File.open('message.txt', 'w') do |f|
            f.write('zone theory is great!')
        end
        @file_reader = File.open('message.txt', 'r')
        @file_writer = File.open('message.encrypted', 'w')
        @message = 'zone theory is great!'
        @string_reader = StringIOAdapter.new(@message)
        @string_writer = StringIOAdapter.new('')
        @encrypter = Encrypter.new('super_secret_key')
    end

    def teardown
        File.delete('message.txt')
        File.delete('message.encrypted')
    end

    def test_file_encrypter
        @encrypter.encrypt(@file_reader, @file_writer)
        @file_writer.close
        File.open('message.encrypted', 'r') do |f|
            encrypted_text = f.read
            assert_not_equal(@message, encrypted_text)
        end

        File.open('message.encrypted', 'r') do |f|
            unencrypted_text = @encrypter.decrypt(f)
            assert_equal(@message, unencrypted_text)
        end
    end

    def test_string_encrypter
        @encrypter.encrypt(@string_reader, @string_writer)
        assert_not_equal(@string_reader.string, @string_writer.string)

        @string_writer.rewind
        unencrypted_text = @encrypter.decrypt(@string_writer)
        assert_equal(@message, unencrypted_text)
    end
end
