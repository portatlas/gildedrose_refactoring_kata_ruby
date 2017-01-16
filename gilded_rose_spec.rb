require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "Item" do
    let(:test_item){Item.new("test_name", 0, 0)}

    describe "initialize" do
      it "It has a name" do
        expect(test_item.name).to eq "test_name"
      end

      it "It has a sell_in value" do
        expect(test_item.sell_in).to eq 0
      end

      it "It has a quality value" do
        expect(test_item.quality).to eq 0
      end
    end

  end

  describe "#update_inventory_EOD" do

    let(:items){[Item.new("foo", 5, 10),
                 Item.new("bar", 5, 0),
                 Item.new("Aged Brie", 5, 10),
                 Item.new("Aged Brie", 5, 50),
                 Item.new("Sulfuras, Hand of Ragnaros", 5, 80),
                 Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 5),
                 Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 5),
                 Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 5),
                 Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 5),
                 Item.new("Conjured", 11, 10),
                 Item.new("Conjured", 0, 0)]}

    before(:each) do
      GildedRose.new(items).update_inventory_EOD()
    end

    describe "rules for standard items" do
      it "does not change the name" do
        expect(items[0].name).to eq "foo"
      end

      it "lowers both values for every item at the end of each day" do
        expect(items[0].quality).to eq 9
      end

      it "changes the quality twice as fast when the sell date has passed" do
        old_items = [Item.new("expired_item", 0, 10)]
        GildedRose.new(old_items).update_inventory_EOD()
        expect(old_items[0].quality).to eq 8
      end

      it "quality of an item is never negative" do
        expect(items[1].quality).to eq 0
      end

      it "the quality of an item is never more than 50" do
        expect(items[3].quality).to eq 50
      end
    end

    describe "rules for \"Aged Brie\"" do
      it "\"Aged Brie\" actually increases in quality the older it gets" do
        expect(items[2].quality).to eq 11
      end
    end

    describe "rules for \"Sulfuras\"" do
      it "\"Sulfuras\" never decreases in quality" do
        expect(items[4].quality).to eq 80
      end

      it "\"Sulfuras\" never has to be sold" do
        expect(items[4].sell_in).to eq 5
      end
    end

    describe "rules for \"Backstage Passes\"" do
      it "\"Backstage passes\" quality increases by 2 when there are 10 days" do
        expect(items[5].quality).to eq 7
      end

      it "\"Backstage passes\" quality increases by 3 when there are 5 days" do
        expect(items[6].quality).to eq 8
      end

      it "\"Backstage passes\" quality drops to 0 after the concert" do
        expect(items[7].quality).to eq 0
      end

      it "\"Backstage passes\" quality increases by 1 when there are more than 10 days left" do
        expect(items[8].quality).to eq 6
      end
    end

    describe "rules for \"Conjured\"" do
      it "degrade in quality twice as fast as normal items" do
        expect(items[9].quality).to eq 8
      end

      it "quality does not go to negative value" do
        expect(items[10].quality).to eq 0
      end
    end

  end

end
