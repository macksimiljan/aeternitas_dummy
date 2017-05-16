class Website < ApplicationRecord
  include Aeternitas::Pollable

  polling_options do
    polling_frequency :daily
  end

  after_initialize :set_defaults

  def poll
    page_content = Net::HTTP.get(URI.parse(url))
    new_source = add_source(page_content)
    CountMerkelJob.perform_async(new_source.id) if new_source
    CountSchulzJob.perform_async(new_source.id) if new_source
  end

  def set_defaults
    self.merkel_word_count = 0
    self.schulz_word_count = 0
  end

end
