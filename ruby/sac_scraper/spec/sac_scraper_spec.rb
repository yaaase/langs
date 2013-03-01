require_relative '../lib/sac_scraper'

describe SteepAndCheapScraper do
  let(:s) { SteepAndCheapScraper.new }

  context "desired matches" do
    it { s.match?("SKIS").should be_true }

    it { s.match?("goggle").should be_true }

    it { s.match?("snow pant").should be_true }

    it { s.match?("mountain hardwear").should be_true }
  end

  context "remembering the title" do
    it "lets me know what the cool shit is" do
      s.stub(:scrape_title).and_return("Black Diamond Verdict Ski")
      s.should_receive(:mail!).with("Black Diamond Verdict Ski")
      s.scrape!
    end
  end
end
