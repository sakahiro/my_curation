# frozen_string_literal: truet
require 'rexml/document'

class ScrapeQiitaJob < ApplicationJob
  queue_as :default

  URL = 'http://qiita.com/popular-items/feed'

  def perform(*_args)
    qiitas = []

    doc = REXML::Document.new(open(URL))
    doc.elements.each('feed/entry') do |entry|
      next if (Time.zone.now - Time.zone.parse(entry.elements['published'].text)) > 21_600
      qiitas << Qiita.new(
        title: entry.elements['title'].text,
        content: entry.elements['content'].text,
        url: entry.elements['link'].attribute('href').to_s
      )
    end

    Qiita.import qiitas
  end
end
