class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.string :rating
      t.string :content
      t.string :contact
      t.integer :user_id
    end
  end

end
