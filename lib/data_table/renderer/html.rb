module DataTable::Renderer::HTML
  def to_html(opts={})
    self.html_opts = opts
    yield self if block_given?
    @view = ActionView::Base.new
    @template = Tilt.new(template_path)
    @template.render @view, locals
  end
end