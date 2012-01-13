module DataTable
  # -Creating a Data Table-
  # To create a data table, pass it an object that you can build scopes on, and parameters:
  #     table = DataTable.new(scopable, params)
  # 
  # -Rendering Data Tables-
  # There are two ways to render a data table.  The first way is to include the DataTable::Helper in your controller,
  # then use the provided +data_table+ helper method to render the table using a template
  # 
  #   data_table @table, :template => 'path/to/partial' do |t|
  #     t.col :id
  #     .....
  #   end
  # 
  # Alternatively you can render it programatically using prebuilt renderers, if they're defined (EXPERIMENTAL).  
  # These will be useful for stuff like CSV, but since the render function won't have access to the current 
  # request/controller/view environment, it's not as useful for views
  #   table.render do |t|
  #   table.render(:class => 'table_class', :id => 'table_id') do |t|
  #   table.render(:csv, :filename => 'asdf.csv') do |t| 
  #   
  #     t.col :id
  #   
  #     t.col :name do |record|
  #       record.fullname
  #     end
  # 
  #     t.col :address, :class => 'address', :method => :formatted_address
  #   
  #   end
  #
  
  def new(*args,&block)
    Base.new(*args,&block)
  end
  module_function :new


end

ActiveRecord::Base.send :include, DataTable::ActiveRecordExt
