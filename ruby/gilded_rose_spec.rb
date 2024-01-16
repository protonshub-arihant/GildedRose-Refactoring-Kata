require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    context "normal product" do
      it "when quality and sell in is decreased by 1" do
        items = [Item.new("Coffee", 11, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Coffee, 10, 9"
      end

      it "when quality is decreased by 2 and sell in value reaches 0" do
        items = [Item.new("Nutella", 0, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Nutella, -1, 8"
      end

      it "checking quality of Oil to never be less than 0" do
        items = [Item.new("Oil", 9, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Oil, 8, 0"
      end
    end

    context "Aged Brie" do
      it "when increasing quality and decreases sell in by 1" do
        items = [Item.new("Aged Brie", 10, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Aged Brie, 9, 11"
      end

      it "when quality is increase by 2 and sell in value reaches 0" do
        items = [Item.new("Aged Brie", 0, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Aged Brie, -1, 12"
      end

      it "checks for quality to never be more than 50" do
        items = [Item.new("Aged Brie", 10, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Aged Brie, 9, 50"
      end
    end

    context "Sulfuras, Hand of Ragnaros" do
      it "never changes it's sell in value" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Sulfuras, Hand of Ragnaros, 10, 80"
      end

      it "never changes it's quality" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Sulfuras, Hand of Ragnaros, 0, 80"
      end
    end

    context "Backstage passes to a TAFKAL80ETC concert" do
      context "when sell in value is greater than 10" do
        it "increases quality and decreases sell in by 1" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 12, 11)]
          GildedRose.new(items).update_quality()
          expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 11, 12"
        end

        it "checks for quality to never be more than 50" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 50)]
          GildedRose.new(items).update_quality()
          expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 19, 50"
        end
      end

      context "when sell in value is less than 11 and greater than 5" do
        it "increases quality by 2 and decreases sell in by 1" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]
          GildedRose.new(items).update_quality()
          expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 9, 12"
        end

        it "quality to never be more than 50" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 50)]
          GildedRose.new(items).update_quality()
          expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 9, 50"
        end
      end

      context "sell in value is less than 6 and greater than 0" do
        it "when increasing quality by 3 and decreasing sell in by 1" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 9)]
          GildedRose.new(items).update_quality()
          expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 3, 12"
        end

        it "checks for quality to never be more than 50" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 51)]
          GildedRose.new(items).update_quality()
          expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 3, 51"
        end
      end

      context "sell in value is 0 or lower" do
        it "when sets quality quals to 0 and decreases sell in by 1" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
          GildedRose.new(items).update_quality()
          expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, -1, 0"
        end
      end
    end
  end
end
