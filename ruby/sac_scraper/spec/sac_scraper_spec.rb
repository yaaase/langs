require_relative '../lib/sac_scraper'

describe SteepAndCheapScraper do
  let(:s) { SteepAndCheapScraper.new }

  context "desired matches" do
    it { s.match?("SKIS").should be_true }

    it { s.match?("goggle").should be_true }

    it { s.match?("snow pant").should be_true }

    it { s.match?("mountain hardwear").should be_true }

    it { s.match?("climbing skins").should be_true }
  end

  context "remembering the title" do
    it "lets me know what the cool shit is" do
      s.stub(:scrape_title).and_return("Black Diamond Verdict Ski")
      s.should_receive(:mail).with("Black Diamond Verdict Ski http://www.steepandcheap.com/")
      s.scrape
    end

    it "does not spam me if the match is the same as before" do
      s.stub(:scrape_title).and_return("Black Diamond Verdict Ski")
      s.instance_variable_set(:@previous_title, "Black Diamond Verdict Ski http://www.steepandcheap.com/")
      s.should_not_receive(:mail)
      s.scrape
    end
  end

  context "exclusions" do
    it "can exclude certain things, like gender specific items" do
      s.stub(:scrape_title).and_return("Mountain Hardwear Women's Thing")
      s.should_not_receive(:mail)
      s.scrape
    end
  end

  context "parse_title" do
    it "parses the title correctly" do
      site = "<html>\n<title>Title</title>\n<div>Some crap</div>\n\n</html>"
      s.parse_title(site).should == "Title"
    end
  end
end
