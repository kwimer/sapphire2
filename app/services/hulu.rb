module Hulu

  module Api

    BASE_URL = "https://www.hulu.com"
    # https://www.hulu.com/start/more_content?channel=&video_type=all&sort=alpha&is_current=0&closed_captioned=0&has_hd=0
    # https://www.hulu.com/press/new-this-month/?date=1-2019

    class << self

      def changes(date = nil)
        changes = []
        date ||= Time.now + 1.month
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

      def series(page = 1)
        series = []
        response = client.get('/start/more_content', params: {video_type: 'tv', sort: 'alpha', page: page})
        list = Nokogiri::HTML(response.body.to_s)
        table = list.at_css('table')
        table.search('td').each do |td|
          link = td.at_css('div.show-title-container a')
          if link.present?
            response = client.follow.get(link['href'])
            detail = Nokogiri::HTML(response.body.to_s)
            seasons = detail.at_css('div.EpisodeCollection__select select').children.map do |option|
              option['value'].to_i
            end
            series << {
                title: link.text,
                hulu_url: link['href'],
                seasons: seasons
            }
          end
        end if table.present?
        results = {
            current_page: page,
            next_page: series.any? && list.at_css("a img[title='Go to the next page']").present? ? page+1 : nil,
            series: series
        }
      end

      def movies(page = 1)
        movies = []
        response = client.get('/start/more_content', params: {video_type: 'movie', sort: 'alpha', page: page})
        list = Nokogiri::HTML(response.body.to_s)
        table = list.at_css('table')
        table.search('td').each do |td|
          link = td.at_css('div.show-title-container a')
          movies << {
              title: link.text,
              hulu_url: link['href']
          } if link.present?
        end if table.present?
        results = {
            current_page: page,
            next_page: movies.any? && list.at_css("a img[title='Go to the next page']").present? ? page+1 : nil,
            movies: movies
        }
      end

      private

      def client
        @client ||= HTTP.persistent BASE_URL
      end

    end

  end

end