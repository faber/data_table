require 'csv'
module DataTable
  module Renderer
    module CSV
      def to_csv(opts={})
        yield self
        CSV.generate do |csv|
          csv << columns.map(&:label)
          records.each do |r|
            csv << columns.map { |c| c.value(r) }
          end
        end
      end
    end
  end
end