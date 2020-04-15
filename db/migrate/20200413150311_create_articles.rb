class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.text :description
      t.string :preview
      t.references :author, foreign_key: {to_table: :users}, null: false

      t.timestamps
    end
  end
end
