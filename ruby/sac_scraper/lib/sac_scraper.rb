require 'net/smtp'
require 'net/http'

class SteepAndCheapScraper
  DesiredMatches = [
    /\bskis?\b/,
    /\bgoggles?\b/,
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
    /\bskins\b/
  ]

  Exclusions = [
    /women/,
    /headlamp/,
    /snowboard/,
    /trekking/
  ]

  def go
    loop do
      scrape
      sleep(5 * 60)
    end
  end

  def scrape
    title = "#{scrape_title} http://www.steepandcheap.com/"
    if match?(title) && title != @previous_title && !exclusion?(title)
      mail(title)
    end
    @previous_title = title
  end

  def scrape_title
    site = Net::HTTP.get('www.steepandcheap.com', '/steepcheap/sac')
    parse_title(site)
  end

  def parse_title(string)
    title_line = string.split(/\n/).select do |line|
      line =~ /<title>/
    end.first.chomp

    title_line.gsub(/.*<title>(.*Steep and Cheap: )?/, '').
               gsub(/<\/title>/, '')
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

  def mail(subject)
    Net::SMTP.start('localhost') do |smtp|
      smtp.send_message(subject, ENV['MY_EMAIL'], ENV['MY_CELL'])
    end
  end
end

if ARGV[0] == 'start'
  begin
    SteepAndCheapScraper.new.go
  rescue
    retry
  end
end
