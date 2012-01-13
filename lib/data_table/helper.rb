module DataTable
  module Helper
    
    # Options
    #   - template - Path to a partial for rendering the table.  The partial will be provided the following locals
    #         - table - the data table object (or something that can turn into one)
    #         - columns - the array of the tables columns (convenience for table.columns)
    #         - records - the array of records resulting from the built query (convenience for table.records)
    #   - other html opts - everything else will be added to table.html_opts
    def data_table(table, opts={})
      table = DataTable.new(table) unless table.is_a?(DataTable::Base)
      template = opts.delete(:template) || table.template_path
      table.html_opts = opts
      yield table if block_given?
      render :partial => template, :locals => table.locals
    end
    
    def sort_url_for_column(col)
      if params[:sort] && params[:sort] == col.sort_key.to_s
        url_for(params.merge(:dir => (params[:dir] == 'asc' ? :desc : :asc)))
      else
        url_for(params.merge(:sort => col.sort_key, :dir => col.sort_dir))
      end
    end
  end
  
end