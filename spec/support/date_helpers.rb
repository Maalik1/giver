module DateHelpers

  def select_date(date, options = {})
    field = options[:from]
    month, day, year = date.split(' ')

    select month, :from => "#{field}_2i"
    select day,   :from => "#{field}_3i"
    select year,  :from => "#{field}_1i"  
  end

end