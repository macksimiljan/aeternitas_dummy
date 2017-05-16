class CountSchulzJob
  include Sidekiq::Worker

  def perform(source_id)
    source = Aeternitas::Source.find(source_id)
    page_content = source.raw_content
    schulz_word_count = page_content.scan('Schulz').size
    website = source.pollable
    website.update(schulz_word_count: schulz_word_count)
  end
end