module RandomDigestGenerator
  extend ActiveSupport::Concern

  DEFAULT_RANDOM_DIGEST_LENGTH = 64

  def self.random_digest(length = DEFAULT_RANDOM_DIGEST_LENGTH)
    message = "#{SecureRandom.uuid}-#{Time.now.to_i}"
    return Digest::SHA256.hexdigest(message)[0..length]
  end
end
