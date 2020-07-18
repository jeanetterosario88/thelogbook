class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.string :type
      t.string :date
      t.integer :rating
      t.string :content
      t.string :contact
      t.integer :user_id
    end
  end

end