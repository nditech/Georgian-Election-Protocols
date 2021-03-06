# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# look for new protocols to download
job_type :scrape_cec, "cd :path/script/scraper && ruby :task >> :path/log/cron.log 2>&1"
# every 15.minutes do
#   scrape_cec "protocol_scraper.rb"
# end
# every 45.minutes do
#   scrape_cec "amendment_scraper.rb"
# end


# register protocols that have been downloaded
every 10.minutes do
  rake "scrape:register_new_images"
end

# look for new volunteers
# every 15.minutes do
#   rake "scrape:register_volunteers"
# end


