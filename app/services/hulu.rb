module Hulu

  CODE = 'hulu'

  class << self

    def changes
      Hulu::Api.changes.each do |change|
        key = "#{change[:date].iso8601}|#{change[:status]}|#{change[:title]}"
        log = ProviderLog.where(provider: provider, action_type: 'change', key: key).first_or_initialize
        log.data = change
        log.save!
      end
      true
    end

    def index(page = 1)
      response = Hulu::Api.media(page)
      response[:records].each do |record|
        key = record[:external_id]
        log = ProviderLog.where(provider: provider, action_type: 'index', key: key).first_or_initialize
        log.data = record
        log.tmdb_id = Tmdb::Api.send("locate_#{record[:type].downcase}", record[:title], record[:year])
        log.save!
      end
      index(response[:next_page]) if response[:next_page]
      true
    end

    def provider
      @provider ||= Provider.where(code: CODE).first_or_create
    end

  end

  module Api

    BASE_URL = "https://www.hulu.com"

    class << self

      # https://www.hulu.com/press/new-this-month/?date=1-2019
      def changes(date = nil)
        changes = []
        date ||= Time.now
        response = client.get('/press/new-this-month/', params: {date: date.strftime("%-m-%Y")})
        list = Nokogiri::HTML(response.body.to_s)
        table = list.at_css('table tbody')
        table.search('tr').each do |tr|
          changes << {
              date: Date.parse(tr.children[1].text.strip),
              title: tr.children[3].at_css('em').text.strip,
              detail: tr.children[3].at_css('span').text.strip,
              category: tr.children[5].text.strip,
              status: tr.children[7].text.strip,
          }
        end if table.present?
        changes
      end

      # https://www.hulu.com/start/more_content?channel=&video_type=all&sort=alpha&is_current=0&closed_captioned=0&has_hd=0
      def media(page = 1)
        records = []
        response = client.get('/start/more_content', params: {video_type: 'all', sort: 'alpha', page: page})
        list = Nokogiri::HTML(response.body.to_s)
        table = list.at_css('table')
        table.search('td').each do |td|
          link = td.at_css('div.show-title-container a')
          if link.present?
            response = client.follow.get(link['href'])
            next unless response.status.success?
            doc = Nokogiri::HTML(response.body.to_s)

            title = doc.at_css('h1.DetailEntityMasthead__title span').text
            tags = doc.at_css('div.DetailEntityMasthead__tags').text.split(' • ')
            type = tags[tags.size - 2]
            year = tags[tags.size - 1]

            record = {
                title: title,
                type: type == 'Movie' ? 'Movie' : 'Series',
                year: year,
                external_id: response.uri.path.split('/').last,
            }

            unless type == 'Movie'
              select = doc.at_css('div.EpisodeCollection__select select')
              record[:seasons] = if select.present?
                                  select.children.map {|option| option['value'].to_i}
                                else
                                  [1]
                                end
            end
            puts record
            records << record
          end
        end if table.present?
        {
            current_page: page,
            next_page: records.any? && list.at_css("a img[title='Go to the next page']").present? ? page + 1 : nil,
            records: records
        }
      end

      private

      def client
        @client ||= HTTP.persistent BASE_URL
      end

    end

  end

end