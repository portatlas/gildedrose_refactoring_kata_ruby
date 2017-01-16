class GildedRose

  MAX_QUALITY = 50

  def initialize(items)
    @items = items
  end

  def update_inventory_EOD()
    @items.each do |item|
      update_quality_for_item_positive_sellin(item)
      update_sell_in(item)
      update_quality_for_item_negative_sellin(item)
    end
  end

  private

  def update_quality_for_item_positive_sellin(item)
    if standard_item?(item)
      decrease_quality(item, 1)
    elsif item.name == "Conjured"
      decrease_quality(item, 2)
    elsif item.quality < MAX_QUALITY
      increase_quality(item)
      if item.name == "Backstage passes to a TAFKAL80ETC concert"
        if item.sell_in < 11
          increase_quality(item)
        end
        if item.sell_in < 6
          increase_quality(item)
        end
      end
    end
  end

  def update_sell_in(item)
    if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
    end
  end

  def update_quality_for_item_negative_sellin(item)
    if item.sell_in < 0
      if standard_item?(item)
        decrease_quality(item, 1)
      else
        item.quality = item.quality - item.quality
      end
    end
  end

  def standard_item?(item)
    item.name != "Aged Brie" &&
    item.name != "Backstage passes to a TAFKAL80ETC concert" &&
    item.name != "Sulfuras, Hand of Ragnaros" &&
    item.name != "Conjured" ? true : false
  end

  def increase_quality(item)
    item.quality += 1
  end

  def decrease_quality(item, increment)
    if item.quality > 0
      item.quality -= increment
    end
  end

end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end