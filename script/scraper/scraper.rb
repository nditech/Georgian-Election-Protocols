#!/usr/bin/env ruby
# encoding: UTF-8

# scraper for protocol app

require 'logger'
require 'json'
require 'net/http'
require 'nokogiri'
require 'fileutils'
require 'open-uri'

# main variables

logger_info = Logger.new("../../log/scraper_info.log")
logger_error = Logger.new("../../log/scraper_error.log")

app_base_url = "https://protocols.jumpstart.ge"
# app_base_url = "http://192.168.2.252:3001"
app_get_uri = "/en/json/missing_protocols"

protocol_dir = "/home/protocols/Protocols/shared/system/protocols"
#protocol_dir = "/home/eric/projects/js/elections/Crowd-Source-Protocols/public/system/protocols"

start_time = Time.now

# check if scraper is already running

checkfile = "prot_scraper_check"

if File.exist?(protocol_dir + '/' + checkfile)
  logger_info.info("Scraper already running.")
else
  FileUtils.touch(protocol_dir + checkfile)

  # get list of missing protocols via API
  begin
    logger_info.info("Getting list of remaining precincts via API call.")
    elections = JSON.load(open(app_base_url + app_get_uri))
  rescue OpenURI::HTTPError => e
    logger_error.error(e)
    FileUtils.rm(protocol_dir + checkfile)
    # Send email!!!
  end

  logger_info.info("Got list of remaining precincts.")

  ##################
  # ELECTION LEVEL
  ##################

  elections.each do |election|

    @election_id = election['election_id']
    @url = election['scraper_url_base']
    @uri = election ['scraper_url_folder_to_images']
    @filename = election['scraper_page_pattern']
    @districts = election['districts']
    @proto_counter = 0 # for counting how many protos downloaded / scrape

    # make election directory if it doesn't exist
    edir = "#{protocol_dir}/#{@election_id}/"
    Dir.mkdir(edir) unless File.exists?(edir)

    @districts.each do |district|

      ##################
      # DISTRICT LEVEL
      ##################
      district.each do |did, precincts|

        fixed_did = did.to_i.to_s # remove leading zero

        # make district directory if it doesn't exist
        ddir = "#{protocol_dir}/#{@election_id}/#{did}/"
        Dir.mkdir(ddir) unless File.exists?(ddir)

        ##################
        # PRECINCT LEVEL
        ##################
        precincts.each do |precinct|
          dec = precinct.split('.')[0].to_i.to_s # dec
          fixed_precinct = precinct.split('.')[1].to_i.to_s # pid

          id = "#{dec}_#{did}.#{precinct}"
          fname = @filename.sub('{id}', id)
          page = "http://#{@url}#{@uri}#{fname}" # http://results.cec.gov.ge/oqm/7/oqmi_51_52.51.05.html

          begin
            logger_info.info("Checking: #{page}")
            response = Net::HTTP.get_response(URI(page))
          rescue => e
            logger_error.error("Error checking page: #{page} | #{e}")
            next
          end

          ######################
          # CHECK HTML RESPONSE
          ######################
          if response.code.to_s == "200"
            logger_info.info("Page exists: #{page}")

            begin
              logger_info.info("Retrieving: #{page}")
              doc = Nokogiri::HTML(open(page))
            rescue => e
              logger_error.error("Unable to retrieve: #{page} | #{e}")
              next
            end

            logger_info.info("Retrieved page: #{page}")

            ##################
            # GET IMAGES
            ##################
            images = doc.css("img")
            links = images.map { |i| i['src']}
            amend_count = 1

            links.each_with_index do |value,index|

              img_uri = value.sub('../../','')
              img_url = "http://#{@url}/#{img_uri}" # http://results.cec.gov.ge/../oqmebi/16/52174/59640.jpg
                                                    # http://results.cec.gov.ge/oqmebi/16/52336/58306.jpg
                                                    # http://results.cec.gov.ge/oqm/7/oqmi_3_04.03.55.html
              img_bname = "#{did}-#{precinct}"

              if index == 0
                begin
                  logger_info.info("Downloading protocol: #{img_bname}")
                  open("#{ddir}#{"#{img_bname}.jpg"}", 'wb') do |pfile|
                    pfile << open(img_url).read
                  end
                  @proto_counter += 1
                rescue => e
                  logger_error.error("Download failed: #{img_bname} | #{e}")
                  next
                end
              else
                begin
                  logger_info.info("Downloading amendment: #{img_bname}")
                  open("#{ddir}#{img_bname}_amendment_#{amend_count}.jpg", 'wb') do |pfile|
                    pfile << open(img_url).read
                  end
                rescue => e
                  logger_error.error("Download failed: #{img_bname} | #{e}")
                  next
                end
                amend_count += 1
              end # if response 200
            end # links

          else
            logger_info.info("Page doesn't exist: #{page}")
            next
          end

          sleep(0)
        end # precincts
      end # district hash
      current_time = Time.now
      time_elapsed = (current_time - start_time)/60
      logger_info.info("Protos Downloaded: #{@proto_counter}")
      logger_info.info("Time elapsed: #{time_elapsed} minutes")
    end # districts
  end # elections


  end_time = Time.now
  duration =  (end_time - start_time)/60 # in minutes
  logger_info.info("Protos Downloaded: #{@proto_counter}")
  logger_info.info("Scraper run time: #{duration} minutes")
  FileUtils.rm(protocol_dir + checkfile)
end # main if
