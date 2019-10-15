module ProductsHelper

  def translate_condition(condition)
    case condition
    when "old_lv_0"
      condition = '新品/未使用'
    when "old_lv_1"
      condition = '目立った傷や汚れなし'
    when "old_lv_2"
      condition = 'やや傷や汚れあり'
    when "old_lv_3"
      condition = '傷や汚れあり'
    when "old_lv_4"
      condition = '状態が悪い'
    end
    condition
  end

  def delivery_days(delivery_days)
    case delivery_days
    when 0
      delivery_days = '1-2日で発送'
    when 1
      delivery_days = '2-4日で発送'
    when 2
      delivery_days = '4-7日で発送'
    end
    delivery_days
  end
end
