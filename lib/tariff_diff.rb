require "faraday"

class TariffDiff
  attr_reader :host1, :host2, :resources_count

  def initialize(arguments)
    @chapter_id = ENV["chapter"]
    @resources_count = 0
    hosts.each do |host|
      conn = connection_for(arguments[host.to_sym], host)
      instance_variable_set :"@#{host}", conn
    end
  end

  def run!
    chapter_diff @chapter_id
    report
  end

  def report
    Rails.logger.debug "\nFinished chapter #{@chapter_}."
    Rails.logger.debug "Compared #{resources_count} resources"
    Rails.logger.debug "#{not_found.count} resource(s) not found"
    Rails.logger.debug "#{not_matching.values.flatten.count} resource(s) don't match:"
    not_matching.each do |kind, resources|
      Rails.logger.debug "\t#{kind}: #{resources.count}"
    end
  end

  def not_found
    # resources not found
    @not_found ||= []
  end

  def not_matching
    # resources not matching
    @not_matching ||= { chapters: [],
                        headings: [],
                        commodities: [] }
  end

  private

  def hosts
    @hosts ||= %w(host1 host2)
  end

  def chapter_diff(id)
    chapter = diff_for "chapter", id
    chapter["headings"].each do |heading|
      heading_code = heading["goods_nomenclature_item_id"]
      heading_diff(heading_code[0,4]) # Heading#short_code
    end
  end

  def heading_diff(id)
    heading = diff_for "heading", id
    heading["commodities"].each do |commodity|
      commodity_id = commodity["goods_nomenclature_item_id"]
      diff_for "commodity", commodity_id
    end
  end

  def diff_for(resource, id)
    @resources_count += 1
    url = "/trade-tariff/#{resource.pluralize}/#{id}.json"
    responses = responses_for(url)
    if responses.first.to_s != responses.last.to_s
      Rails.logger.debug "\n#{resource} #{id} doesn't match. Endpoint: #{url}"
      not_matching[resource.pluralize.to_sym] << id
      show_diff(responses) if responses.all?{|r| r.is_a?(Hash)}
    end
    responses.first
  end

  def show_diff(responses)
    Rails.logger.debug "\tdiff:"
    Rails.logger.debug "\thost1 (#{host1.url_prefix}):\n#{responses.first.diff(responses.last)}"
    Rails.logger.debug "\thost2 (#{host2.url_prefix}):\n#{responses.last.diff(responses.first)}"
  end

  def responses_for(url)
    hosts.map { |h|
      host = send(h)
      host.get(url).tap do |response|
        # 404 urls
        if response.status == 404
          full_url = response.env[:url].to_s
          Rails.logger.debug "404: #{full_url}"
          not_found << full_url
        end
      end
    }.map(&:body)
  end

  def connection_for(url, host_name)
    Faraday.new(url: url) do |conn|
      conn.adapter Faraday.default_adapter
      conn.request :json
      conn.response :json, :content_type => /\bjson$/

      # setup basic auth (if needed)
      user   = ENV["#{host_name}user"]
      passwd = ENV["#{host_name}passwd"]
      if user.present? or passwd.present?
        conn.request :basic_auth, user, passwd
      end
    end
  end
end
