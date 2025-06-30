class PostPresenter
  include ActionView::Helpers::TextHelper

  attr_reader :post

  def initialize(post)
    @post = post
  end

  def title
    post.title.titleize
  end

  def content
    post.content.presence || "-"
  end

  def excerpt
    post.excerpt.presence || "-"
  end

  def published_at
    post.published_at ? post.published_at.strftime("%b %d, %Y") : "-"
  end

  def status
      post.status&.titleize || "-"
  end

  def author_name
    post.author&.username || "Unknown"
  end
end
