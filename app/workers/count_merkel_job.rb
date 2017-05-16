class CountMerkelJob
  include Sidekiq::Worker

  def perform(source_id)
    source = Aeternitas::Source.find(source_id)
    page_content = source.raw_content
    merkel_word_count = page_content.scan('Merkel').size
    website = source.pollable
    website.update(merkel_word_count: merkel_word_count)
  end
end