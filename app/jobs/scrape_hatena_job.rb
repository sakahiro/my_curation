# frozen_string_literal: true
require 'rexml/document'

class ScrapeHatenaJob < ApplicationJob
  queue_as :default

  URL = 'http://b.hatena.ne.jp/hotentry/it.rss'

  def perform(*_args)
    opt = {}
    opt['User-Agent'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_0) \
      AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36'

    hatenas = []

    doc = REXML::Document.new(open(URL, opt))
    doc.elements.each('rdf:RDF/item') do |item|
      next if (Time.zone.now - Time.zone.parse(item.elements['dc:date'].text)) > 21_600
      next unless item.elements['hatena:bookmarkcount'].text.to_i > 50
      hatenas << Hatena.new(
        title: item.elements['title'].text,
        content: item.elements['description'].text,
        url: item.elements['link'].text
      )
    end

    Hatena.import hatenas
  end
end
