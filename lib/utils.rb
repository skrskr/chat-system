module Utils
    def generate_random_token(length = 8)
      SecureRandom.hex(length)
    end
end