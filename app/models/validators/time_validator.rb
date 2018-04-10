class TimeValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    # checking for allow_blank
    return true if options[:allow_blank] && value.blank?

    actual_attr = attribute.to_s
    actual_attr.slice! "_before_type_cast"

    begin
      value = Time.parse(value.to_s)

      # checking for minimum
      if(options[:minimum].present?)
        minimum_str = options[:minimum].is_a?(String) ? options[:minimum] : record[options[:minimum]]
        minimum = Time.parse(minimum_str.to_s)
        record.errors.add(actual_attr, :must_greater_than, minimum: minimum_str) unless value > minimum
      end

      # checking for maximum
      if(options[:maximum].present?)
        maximum_str = options[:maximum].is_a?(String) ? options[:maximum] : record[options[:maximum]]
        maximum = Time.parse(maximum_str.to_s)
        record.errors.add(actual_attr, :must_less_than, maximum: maximum_str) unless value < maximum
      end

    rescue ArgumentError
      record.errors.add(actual_attr, :invalid_time)
    end
  end

end
