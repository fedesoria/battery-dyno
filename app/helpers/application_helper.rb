module ApplicationHelper
  def to_custom(date)
    date.strftime('%m-%d-%H-%M')
  end
end
