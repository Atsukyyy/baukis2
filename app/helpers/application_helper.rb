module HtmlBuilder
  def markup(tag_name = nil, options = {})
    root = Nokogiri::HTML::DocumentFragment.parse('')
    Nokogiri::HTML::Builder.with(root) do |doc|
      if tag_name
        doc.send(tag_name, options) do
          yield(doc)
        end
      else
        yield(doc)
      end
    end
    root.to_html.html_safe
  end
end

module ApplicationHelper
  include HtmlBuilder

  def document_title
    if @title.present?
      "#{@title} - Baukis"
    else
      'Baukis'
    end
  end
end
