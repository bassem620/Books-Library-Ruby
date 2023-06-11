require 'rails_helper'

describe "Books API", type: :request do
    describe "GET /books" do
        let!(:author) {FactoryBot.create(:author, first_name: "Test author FN", last_name: "test author 1 LN", age: 30)}
        before do
            FactoryBot.create(:book, title: "Test author 1", author_id: author.id)
            FactoryBot.create(:book, title: "Test author 2", author_id: author.id)
        end
        it 'Get all books' do
        get '/api/v1/books'
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(2)
        end
    end

    describe "POST /books" do
        it 'create a new book' do
            expect {
                post '/api/v1/books', params: { 
                    book: { title: "Test author 1"},
                    author: {first_name: "Andy", last_name: "Weir", age: 48}
                }
            }.to change { Book.count }.from(0).to(1)
            expect(response).to have_http_status(:created)
            expect(Author.count).to eq(1)
        end
    end

    describe "DELETE /book/:id" do
        let!(:author) {FactoryBot.create(:author, first_name: "Test author FN", last_name: "test author 1 LN", age: 30)}
        let!(:book) {FactoryBot.create(:book, title: "Test author 3", author_id: author.id )}
        it 'delete a book' do
            expect {
                delete "/api/v1/books/#{book.id}"
            }.to change { Book.count }.from(1).to(0)
            expect(response).to have_http_status(:no_content)
        end
    end
end
