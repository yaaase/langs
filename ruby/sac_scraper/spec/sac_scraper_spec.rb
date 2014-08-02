require_relative '../lib/sac_scraper'

describe SteepAndCheapScraper do
  let(:s) { SteepAndCheapScraper.new }

  context "desired matches" do
    it { expect(s.match?("SKIS")).to eq(true) }

    it { expect(s.match?("goggle")).to eq(true) }

    it { expect(s.match?("snow pant")).to eq(true) }

    it { expect(s.match?("mountain hardwear")).to eq(true) }

    it { expect(s.match?("climbing skins")).to eq(true) }
  end

  context "remembering the title" do
    it "lets me know what the cool shit is" do
      allow(s).to receive(:scrape_title).and_return("Black Diamond Verdict Ski")
      expect(s).to receive(:mail).with("Black Diamond Verdict Ski http://www.steepandcheap.com/")
      s.scrape
    end

    it "does not spam me if the match is the same as before" do
      allow(s).to receive(:scrape_title).and_return("Black Diamond Verdict Ski")
      s.instance_variable_set(:@previous_title, "Black Diamond Verdict Ski http://www.steepandcheap.com/")
      expect(s).to_not receive(:mail)
      s.scrape
    end
  end

  context "exclusions" do
    it "can exclude certain things, like gender specific items" do
      allow(s).to receive(:scrape_title).and_return("Mountain Hardwear Women's Thing")
      expect(s).to_not receive(:mail)
      s.scrape
    end
  end

  context "parse_title" do
    it "parses the title correctly" do
      site = "<html>\n<title>Title</title>\n<div>Some crap</div>\n\n</html>"
      expect(s.parse_title(site)).to eq("Title")
    end
  end
end
