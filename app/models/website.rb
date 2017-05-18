class Website < ApplicationRecord
  include Aeternitas::Pollable

  validates :url, presence: true, length: {minimum: 5}

  polling_options do
    polling_frequency :daily
  end

  after_initialize :set_defaults

  def poll
    page_content = HTTParty.get(URI.parse(url))
    new_source = add_source(page_content)
    CountMerkelJob.perform_async(new_source.id) if new_source
    CountSchulzJob.perform_async(new_source.id) if new_source
  end

  def set_defaults
    self.merkel_word_count = 0
    self.schulz_word_count = 0
  end

  def nice_last_polling
    nice_date(last_polling)
  end

  def nice_next_polling
    nice_date(next_polling)
  end

  private

  def nice_date(date)
    if date.nil?
      '--'
    else
      date.strftime('%F %T')
    end
  end

end
