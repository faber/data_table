module DataTable
  
  class Column
    attr_accessor :key, :method_name, :method_block, :opts, :html_opts

    def initialize(key, opts={}, &block)
      self.key = key

      if opts.key?(:method)
        self.method_name = opts.delete :method
      elsif block_given?
        self.method_block = block
      else
        self.method_name = key
      end
      
      opts[:sort] = key if !opts.key?(:sort)
      opts[:dir]  ||= :asc

      self.html_opts = opts.delete(:html) || {}
      html_opts[:class] ||= key
      self.opts = opts
    end
    
    def sortable?
      !!opts[:sort]
    end
    def sort_key
      opts[:sort]
    end
    def sort_dir
      opts[:dir]
    end
    
    def label
      opts[:label] || key.to_s.titleize
    end
    
    def value(record)
      if method_name.present?
        record.send(method_name) if record.respond_to?(method_name)
      else
        method_block.call(record)
      end
    end
    
  end
  
end