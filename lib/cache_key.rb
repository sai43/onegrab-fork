module CacheKey
  DOMAIN = ENV['DOMAIN']

  def self.key(resource:, id: nil, slug: nil)
    if id.nil? && slug.nil?
      raise ArgumentError, "Either id or slug must be provided"
    end

    identifier = id ? "id:#{id}" : "slug:#{slug}"
    "#{DOMAIN}:#{resource}:#{identifier}"
  end
end
