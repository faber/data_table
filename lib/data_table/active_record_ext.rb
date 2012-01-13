module DataTable
  module ActiveRecordExt
    module ClassMethods
      def sort_scope(*args, &block)
        if block_given?
          name = args.first
          scope("sort_#{name}", block)
        else
          args.each do |name|
            sort_scope name do |dir|
              order('%s %s' % [name, dir])
            end
          end          
        end
      end
    end
    
    def self.included(klass)
      klass.extend ClassMethods
    end
  end
  
end