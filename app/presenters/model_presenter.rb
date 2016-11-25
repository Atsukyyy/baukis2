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

class ModelPresenter
  include HtmlBuilder

  attr_reader :object, :view_context
  delegate :raw, :link_to, to: :view_context

  def initialize(object, view_context)
    @object = object
    @view_context = view_context
  end
end
