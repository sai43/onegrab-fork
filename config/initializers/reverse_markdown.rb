# config/initializers/reverse_markdown.rb
ReverseMarkdown.config do |config|
  config.github_flavored = true
  config.unknown_tags    = :bypass
  config.tag_border      = ''
end
