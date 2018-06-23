module Kaminari
  module ActiveRecordRelationMethods
    def with_custom_count(count)
      @custom_count = count
      extend ::Kaminari::PaginatableWithCustomCount
    end
  end

  module PaginatableWithCustomCount
    def total_count(column_name = :all, _options = nil) #:nodoc:
      return @custom_count if defined?(@custom_count) && @custom_count
      return @total_count if defined?(@total_count) && @total_count

      # There are some cases that total count can be deduced from loaded records
      if loaded?
        # Total count has to be 0 if loaded records are 0
        return @total_count = 0 if (current_page == 1) && @records.empty?
        # Total count is calculable at the last page
        return @total_count = (current_page - 1) * limit_value + @records.length if @records.any? && (@records.length < limit_value)
      end

      # #count overrides the #select which could include generated columns referenced in #order, so skip #order here, where it's irrelevant to the result anyway
      c = except(:offset, :limit, :order)
      # Remove includes only if they are irrelevant
      c = c.except(:includes) unless references_eager_loaded_tables?
      # .group returns an OrderedHash that responds to #count
      c = c.count(column_name)
      @total_count = if c.is_a?(Hash) || c.is_a?(ActiveSupport::OrderedHash)
        c.count
     elsif c.respond_to? :count
       c.count(column_name)
     else
       c
      end
    end
  end
end
