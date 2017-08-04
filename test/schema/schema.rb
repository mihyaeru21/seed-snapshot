ActiveRecord::Schema.define do
  create_table :rents, force: true do |t|
    t.integer :book_id
    t.integer :user_id
    t.timestamps
  end

  create_table :books, force: true do |t|
    t.integer :user_id
    t.timestamps
  end

  create_table :users, force: true do |t|
    t.timestamps
  end
end
