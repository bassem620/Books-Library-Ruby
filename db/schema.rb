ActiveRecord::Schema[7.0].define(version: 2023_06_11_195220) do
  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
