class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body
      t.references :user, null: false, foreign_key: true
      t.datetime :published_at
      t.string :image_url

      t.timestamps
    end
  end
end
