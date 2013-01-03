namespace :visa_scraper do
  desc "scraping visas"
  task :scrape => :environment do
    VisaScraper.scrape
  end
end

