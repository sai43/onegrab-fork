module ApplicationHelper
  include Pagy::Frontend

    def markdown(text)
      renderer = Redcarpet::Render::HTML.new(
        filter_html: true,
        hard_wrap: true
      )
      options = {
        autolink: true,
        tables: true,
        fenced_code_blocks: true,
        strikethrough: true,
        underline: true,
        highlight: true,
        quote: true,
        footnotes: true
      }
      markdown = Redcarpet::Markdown.new(renderer, options)
      markdown.render(text).html_safe
    end
end
