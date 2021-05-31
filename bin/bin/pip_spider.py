import scrapy


class PipSpider(scrapy.Spider):
    name = 'pipscrape'
    # start_urls = [
    #     f'https://pypi.org/search/?q={query}',
    # ]
    def __init__(self, query='', **kwargs):
        self.start_urls = [f'https://pypi.org/search/?q={query}']
        print(self.start_urls)
        super().__init__(**kwargs)

    def parse(self, response):
        for package in response.css('.package-snippet'):
            yield {
                'title': package.css('span.package-snippet__name::text').get(),
                'version': package.css('span.package-snippet__version::text').get(),
                'description': package.css('p.package-snippet__description::text').get(),
            }

        # next = response.css('a.button-group__button::attr("href")')[-1]

        if len(response.css('.button-disabled')) > 0:
            next_page = None
        else:
            next_page = response.css('a.button-group__button::attr("href")')[-1].get()

        if next_page is not None:
            yield response.follow(next_page, self.parse)
