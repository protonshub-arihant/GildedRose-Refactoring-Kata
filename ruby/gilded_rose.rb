class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        decrease_item_quality(item) 
      else
        increase_item_quality(item)
      end

      item.sell_in = item.sell_in - 1 if item.name != "Sulfuras, Hand of Ragnaros" 

      after_sell_in_update_quality(item)
    end
  end
end


private

def decrease_item_quality(item)
  if item.name != "Sulfuras, Hand of Ragnaros" and item.quality > 0
    if item.name != "Conjured Mana Cake"
        item.quality = item.quality - 1
    else
        item.quality = item.quality - 2
    end
  end
end

def increase_item_quality(item)
  if item.quality < 50
    item.quality = item.quality + 1
    if item.name == "Backstage passes to a TAFKAL80ETC concert"
      item.quality = item.quality + 1 if item.sell_in < 11 and item.quality < 50            
      item.quality = item.quality + 1 if item.sell_in < 6 and item.quality < 50
    end
  end
end

def after_sell_in_update_quality(item)
  if item.sell_in < 0
    if item.name != "Aged Brie"
      if item.name != "Backstage passes to a TAFKAL80ETC concert"
        item.quality = item.quality - 1 if item.quality > 0 and item.name != "Sulfuras, Hand of Ragnaros"
        item.quality = item.quality - 1 if item.quality > 0 and item.name == "Conjured Mana Cake"
      else
        item.quality = item.quality - item.quality
      end
    elsif item.quality < 50 
      item.quality = item.quality + 1 
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
