# Class that encrypts the contents of a file and 
# writes it to another file. Note that it expects
# files as input, but perhaps we need it for strings
class Encrypter
    def initialize(key)
        @key = key
    end

    def encrypt(reader, writer)
        key_index = 0
        until reader.eof?
            encrypted_char = reader.getbyte ^ @key.getbyte(key_index)
            writer.putc(encrypted_char)
            key_index = (key_index + 1) % @key.size
        end
    end

    def decrypt(reader)
        message = ''
        key_index = 0
        until reader.eof?
            encrypted_byte = reader.getbyte
            key_byte = @key.getbyte(key_index)
            decrypted_byte = (encrypted_byte ^ key_byte)
            message << decrypted_byte.chr('UTF-8')
            key_index = (key_index + 1) % @key.size
        end
        return message
    end

end

# Adapter class allowing a client to use the Encrypter
# class with strings instead of files.
class StringIOAdapter
    attr_reader :string

    def initialize(string)
        @string = string
        @position = 0
    end

    def getbyte
        if @position >= @string.length
            raise EOFError
        end
        ch = @string.getbyte(@position)
        @position += 1
        return ch
    end

    def rewind(pos=0)
        @position = pos
    end 

    def putc(ch)
        @string << ch
        @position += 1
    end

    def eof?
        return @position >= @string.length
    end
end

