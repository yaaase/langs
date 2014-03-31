require 'net/http'
require 'net/smtp'
require 'uri'
require 'rss'

URL = "http://some-rss-feed.com/rss_feed"
EMAIL = "your@email.com"
SLEEP_PERIOD = 60 * 60 * 24 # 1 day

loop do

  response = Net::HTTP.get_response(URI.parse(URL))
  rss = RSS::Parser.parse(response.body)

  results = rss.items.select do |item|
    item.description =~ /regex to match description/i
  end

  entries = results.map { |r| [r.title, r.description, r.date, r.link] }

  email_body = "Matching Contents:\n"
  entries.each do |entry|
    email_body << "\n#{entry.join("\n")}\n"
  end

  Net::SMTP.start('localhost') do |smtp|
    smtp.send_message(email_body, EMAIL, EMAIL)
  end

  sleep(SLEEP_PERIOD)

end
