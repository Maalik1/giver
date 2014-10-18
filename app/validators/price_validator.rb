class PriceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || 'is not a valid price') unless value.to_s =~ /\A(\$)?(\d+)(\.|,)?\d{0,2}?\z/
  end
end