require 'net/smtp'

class SteepAndCheapScraper
  DesiredMatches = [
    /\bskis?\b/,
    /\bgoggles?\b/,
    /\bblack diamond\b/,
    /\bmountain hardwear\b/,
    /\barc'teryx\b/,
    /\bsnow pants?\b/,
    /\bgopro\b/,
    /\bbeacon\b/,
    /\bavalung\b/,
    /\bgloves?\b/,
    /snow/,
    /\bski pant\b/,
    /\bice tool\b/,
    /\bice axe\b/,
    /\bcrampon\s?\b/,
    /\btelemark\b/,
    /\bhammerhead\b/,
    /\btele.*bindings?\b/,
    /\btele.*boot\s?\b/,
    /\bskins\b/
  ]

  Exclusions = [
    /women/,
    /headlamp/
  ]

  def go!
    loop do
      scrape!
      sleep(300)
    end
  end

  def scrape!
    title = "#{scrape_title} http://www.steepandcheap.com/"
    if match?(title) && title != @previous_title && !exclusion?(title)
      mail!(title)
    end
    @previous_title = title
  end

  def scrape_title
    %x(curl www.steepandcheap.com 2>/dev/null | grep -E "<title>" | sed -e "s_<title>__g" -e "s_</title>__g" -e "s_Steep and Cheap: __g")
  end

  def exclusion?(string)
    regexp_match?(Exclusions, string)
  end

  def match?(string)
    regexp_match?(DesiredMatches, string)
  end

  def regexp_match?(list, string)
    list.each do |regexp|
      return true if string.downcase =~ regexp
    end
    return false
  end

  def mail!(subject)
    Net::SMTP.start('localhost') do |smtp|
      smtp.send_message(subject, ENV['MY_EMAIL'], ENV['MY_CELL'])
    end
  end
end

if ARGV[0] == "start"
  SteepAndCheapScraper.new.go!
end
