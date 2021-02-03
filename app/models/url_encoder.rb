class UrlEncoder

    DEFAULT_ALPHABET = 'FY2j6MrhkJedR8LNBSAamuH9xDUyfP5QCX4GtnW7vcVqbgps3TwKE'
    DEFAULT_BLOCK_SIZE = 22

    def initialize(alphabet=DEFAULT_ALPHABET, block_size=DEFAULT_BLOCK_SIZE)
        @alphabet = alphabet
        @block_size = block_size
        @mask = (1 << block_size) - 1
        @mapping = (0..block_size).to_a
    end

    def encode_url(number, min_length=3)
        enbase(encode(number), min_length)
    end

    def decode_url(number)
        decode(debase(number))
    end

    def encode(number)
        (number & ~@mask) | _encode(number & @mask)
    end

    def _encode(number)
        result = 0
        @mapping.each_with_index do |value, index|
            if (number & (1 << index)) > 0
                result |= (1 << value)
            end
        end
        result
    end

    def decode(number)
        (number & ~@mask) | _decode(number & @mask)
    end

    def _decode(number)
        result = 0
        @mapping.each_with_index do |value, index|
            if (number & (1 << value)) > 0
                result |= (1 << index)
            end
        end
        result
    end

    def enbase(x, min_length=0)
        result = _enbase(x)
        padding = @alphabet[0] * [(min_length - result.length), 0].max
        "#{padding}#{result}"
    end

    def _enbase(x)
        if x < @alphabet.length
            return @alphabet[x]
        end
        enbase(x/@alphabet.length) + @alphabet[x % @alphabet.length]
    end

    def debase(x)
        result = 0
        x.reverse.each_char.with_index do |c, i|
            result += @alphabet.index(c) * (@alphabet.length ** i)
        end
        result
    end
end