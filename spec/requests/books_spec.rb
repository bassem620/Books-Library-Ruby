require 'rails_helper'

describe "Books API", type: :request do
    describe "GET /books" do
        before do
            FactoryBot.create(:book, title: "Test author 1", author: "Test title 1")
            FactoryBot.create(:book, title: "Test author 2", author: "Test title 2")
        end
        it 'Get all books' do
        get '/api/v1/books'
        puts response.body
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(6)
        end
    end

    describe "POST /books" do
        it 'create a new book' do
        expect {
            post '/api/v1/books', params: { book: { title: "Test author 1", author: "Test title 1"}}
        }.to change { Book.count }.from(4).to(5)
        expect(response).to have_http_status(:created)
        end
    end

    describe "DELETE /book/:id" do
        let!(:book) {FactoryBot.create(:book, title: "Test author 3", author: "Test title 3")}
        it 'delete a book' do
            expect {
                delete "/api/v1/books/#{book.id}"
            }.to change { Book.count }.from(5).to(4)
            expect(response).to have_http_status(:no_content)
        end
    end
end
