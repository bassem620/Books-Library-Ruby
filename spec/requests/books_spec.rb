require 'rails_helper'

describe "Books API", type: :request do

    let!(:first_author) {FactoryBot.create(:author, first_name: "Test author 1 FN", last_name: "test author 1 LN", age: 30)}
    let!(:second_author) {FactoryBot.create(:author, first_name: "Test author 2 FN", last_name: "test author 2 LN", age: 45)}

    describe "GET /books" do
        before do
            FactoryBot.create(:book, title: "Test book 1", author_id: first_author.id)
            FactoryBot.create(:book, title: "Test book 2", author_id: second_author.id)
        end

        it 'Get all books' do
            get '/api/v1/books'
            expect(response).to have_http_status(:success)
            expect(response_body.size).to eq(2)
            expect(response_body).to eq(
                [
                    {
                        'id' => 1,
                        'title' => 'Test book 1',
                        'author_name' => 'Test author 1 FN test author 1 LN',
                        'author_age' => 30
                    },
                    {
                        'id' => 2,
                        'title' => 'Test book 2',
                        'author_name' => 'Test author 2 FN test author 2 LN',
                        'author_age' => 45
                    }
                ]
            )
        end

        it 'returns a subset of books based on limit' do
            get "/api/v1/books", params: {limit: 1}
            expect(response).to have_http_status(:success)
            expect(response_body.size).to eq(1)
            expect(response_body).to eq(
                [
                    {
                        'id' => 1,
                        'title' => 'Test book 1',
                        'author_name' => 'Test author 1 FN test author 1 LN',
                        'author_age' => 30
                    }
                ]
            )
        end

        it 'returns a subset of books based on limit and offset' do
            get "/api/v1/books", params: {limit: 1, offset: 1}
            expect(response).to have_http_status(:success)
            expect(response_body.size).to eq(1)
            expect(response_body).to eq(
                [
                    {
                        'id' => 2,
                        'title' => 'Test book 2',
                        'author_name' => 'Test author 2 FN test author 2 LN',
                        'author_age' => 45
                    }
                ]
            )
        end
    end

    describe "POST /books" do
        it 'create a new book' do
            expect {
                post '/api/v1/books', params: { 
                    book: { title: "Test book"},
                    author: {first_name: "Andy", last_name: "Weir", age: 48}
                }
            }.to change { Book.count }.from(0).to(1)
            expect(response).to have_http_status(:created)
            expect(Author.count).to eq(3)
            expect(response_body).to eq(
                {
                    'id' => 1,
                    'title' => 'Test book',
                    'author_name' => 'Andy Weir',
                    'author_age' => 48
                }
            )
        end
    end

    describe "DELETE /book/:id" do
        let!(:book) {FactoryBot.create(:book, title: "Test author 3", author_id: first_author.id )}
        it 'delete a book' do
            expect {
                delete "/api/v1/books/#{book.id}"
            }.to change { Book.count }.from(1).to(0)
            expect(response).to have_http_status(:no_content)
        end
    end
end
