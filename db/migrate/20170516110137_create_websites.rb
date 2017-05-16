class CreateWebsites < ActiveRecord::Migration[5.0]
  def change
    create_table :websites do |t|
      t.string :url
      t.integer :merkel_word_count
      t.integer :schulz_word_count

      t.timestamps
    end
  end
end
