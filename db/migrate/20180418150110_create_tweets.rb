class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.string :username
      t.string :message_body

      t.timestamps
    end
  end
end
