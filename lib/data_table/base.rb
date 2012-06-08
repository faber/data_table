require 'data_table/renderer/csv'
require 'data_table/renderer/html'
module DataTable
  class Base
    
    include Renderer::HTML
    include Renderer::CSV
    
    attr_accessor :finder
    attr_accessor :params
    attr_accessor :template_path
    attr_accessor :html_opts
    
    attr_reader :scopes, :filters
    attr_reader :columns
    
    def initialize(finder, params={})
      @columns        = []
      @scopes         = []
      @filters        = []
      @html_opts      = {}
      @finder         = finder
      @sort_dir       = params[:dir] || :asc
      @sort_key       = params[:sort]
      @page           = params[:page]
      @per_page       = params[:per_page]
      @template_path  = params[:template_path] || DataTable.default_template # File.expand_path('../_data_table.html.haml', __FILE__)
      yield self if block_given?
    end
    
    # def render(html_opts={})
    def render(*args)
      opts = args.extract_options!
      type = args.empty? ? :html : args.first
      if respond_to?("to_#{type}")
        send "to_#{type}", opts
      else
        raise "Don't know how to render data table as #{type}"
      end
    end
    
    def scope(*args)
      @scopes << args
    end
    
    def filter(obj)
      @filters << obj
    end
    
    def sort_key(sort)
      @sort_key = sort.to_sym
    end
    def sort_dir(dir)
      @sort_dir = dir
    end
    
    def page(page)
      @page = page
    end
    def per_page(per_page)
      @per_page = per_page
    end
    
    def records(reload=false)
      if @records.nil? || reload
        scope = finder.scoped
        # Apply scopes
        @scopes.each { |s| scope = scope.send(s.first, *s[1...s.length]) }
        # Apply filters
        @filters.each { |filter| scope = filter.apply(scope) }
        # Apply sorts
        scope = scope.send('sort_%s' % @sort_key, @sort_dir)  if @sort_key
        # Apply paging
        scope = scope.page(@page).per(@per_page)              if @page
        @records = scope
      end
      @records
    end
    
    def column(*args, &block)
      @columns << Column.new(*args, &block)
    end

    alias_method :col, :column


    def locals
      {
        :table => self,
        :columns => columns,
        :records => records,
        :sort_key => @sort_key,
        :sort_dir => @sort_dir
      }
    end
    
    
  end
end