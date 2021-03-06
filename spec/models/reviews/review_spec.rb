require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :title}
    it { should validate_presence_of :text}
    it { should validate_presence_of :user}
    it { should validate_presence_of :rating}
  end

  describe 'Relationships' do
    it { should belong_to :book}
  end

  describe 'Class Methods' do
    it '.sort_newest returns reviews given the time submitted, and symbol of :asc or :desc' do
      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")

      book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
      book_2 = author_2.books.create(title: "Title_2", pages: 400, year: 1998, cover: "othermadeupurl.com")
      book_2.authors << author_3
      book_3 = author_2.books.create(title: "Art of Data", pages: 400, year: 2000, cover: "otherothermadeupurl.com")

      review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")
      review_2 = book_2.reviews.create(title: "Nice Read" , text: "Very enjoyable", rating: 4, user: "User_1")
      review_3 = book_2.reviews.create(title: "If you have too" , text: "Meh", rating: 3, user: "User_2")
      review_4 = book_3.reviews.create(title: "Data Pro" , text: "What a list!", rating: 5, user: "User_2")

      oldest = Review.sorted_by_time(:asc)
      newest = Review.sorted_by_time(:desc)

      expect(oldest).to eq([review_1,review_2,review_3,review_4])
      expect(newest).to eq([review_4,review_3,review_2,review_1])
    end
    it '.most_reviews returns users names sorted by number of reviews created' do

      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")

      book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
      book_2 = author_2.books.create(title: "Title_2", pages: 400, year: 1998, cover: "othermadeupurl.com")
      book_2.authors << author_3
      book_3 = author_2.books.create(title: "Art of Data", pages: 400, year: 2000, cover: "otherothermadeupurl.com")

      review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")
      review_2 = book_2.reviews.create(title: "Nice Read" , text: "Very enjoyable", rating: 4, user: "User_1")
      review_3 = book_2.reviews.create(title: "If you have too" , text: "Meh", rating: 3, user: "User_2")
      review_4 = book_3.reviews.create(title: "Data Pro" , text: "What a list!", rating: 5, user: "User_2")
      review_5 = book_3.reviews.create(title: "Data Pro1" , text: "What a list!", rating: 5, user: "User_3")
      review_6 = book_3.reviews.create(title: "Data Pro2" , text: "What a list!", rating: 5, user: "User_1")

      most_reviews = Review.most_reviews
      expect(most_reviews.pluck(:user)).to eq(["User_1", "User_2","User_3"])
      expect(most_reviews.map{|r| r.review_count}).to eq([3,2,1])
    end

    it '.review_ag returns avg rating for a collection of reviews' do

      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")

      book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
      book_2 = author_2.books.create(title: "Title_2", pages: 400, year: 1998, cover: "othermadeupurl.com")
      book_2.authors << author_3
      book_3 = author_2.books.create(title: "Art of Data", pages: 400, year: 2000, cover: "otherothermadeupurl.com")

      review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")
      review_2 = book_2.reviews.create(title: "Nice Read" , text: "Very enjoyable", rating: 4, user: "User_1")
      review_3 = book_2.reviews.create(title: "If you have too" , text: "Meh", rating: 3, user: "User_2")
      review_4 = book_3.reviews.create(title: "Data Pro" , text: "What a list!", rating: 5, user: "User_2")
      review_5 = book_3.reviews.create(title: "Data Pro1" , text: "What a list!", rating: 5, user: "User_3")
      review_6 = book_3.reviews.create(title: "Data Pro2" , text: "What a list!", rating: 5, user: "User_1")

      review_avg = book_2.reviews.avg_rating
      expect(review_avg).to eq(3.5)
    end

    it '.rating_sort returns reviews in order of rating' do

      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")

      book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
      book_2 = author_2.books.create(title: "Title_2", pages: 400, year: 1998, cover: "othermadeupurl.com")
      book_2.authors << author_3
      book_3 = author_2.books.create(title: "Art of Data", pages: 400, year: 2000, cover: "otherothermadeupurl.com")

      review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")
      review_2 = book_2.reviews.create(title: "Nice Read" , text: "Very enjoyable", rating: 4, user: "User_1")
      review_3 = book_2.reviews.create(title: "If you have too" , text: "Meh", rating: 3, user: "User_2")
      review_4 = book_3.reviews.create(title: "Data Pro" , text: "What a list!", rating: 2, user: "User_2")
      review_5 = book_3.reviews.create(title: "Data Pro1" , text: "What a list!", rating: 1, user: "User_3")


      top_reviews = Review.rating_sort(:desc)
      bottom_reviews = Review.rating_sort(:asc)

      expect(top_reviews).to eq([review_1,review_2,review_3,review_4,review_5])
      expect(bottom_reviews).to eq([review_5,review_4,review_3,review_2,review_1])
    end

    it '.total_reviews returns numer of total reviews.' do

      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")

      book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
      book_2 = author_2.books.create(title: "Title_2", pages: 400, year: 1998, cover: "othermadeupurl.com")
      book_2.authors << author_3
      book_3 = author_2.books.create(title: "Art of Data", pages: 400, year: 2000, cover: "otherothermadeupurl.com")

      review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")
      review_2 = book_2.reviews.create(title: "Nice Read" , text: "Very enjoyable", rating: 4, user: "User_1")
      review_3 = book_2.reviews.create(title: "If you have too" , text: "Meh", rating: 3, user: "User_2")
      review_4 = book_3.reviews.create(title: "Data Pro" , text: "What a list!", rating: 2, user: "User_2")
      review_5 = book_3.reviews.create(title: "Data Pro1" , text: "What a list!", rating: 1, user: "User_3")

      all_reviews = Review.total_reviews
      book_1_reviews = book_1.reviews.total_reviews

      expect(all_reviews).to eq(5)
      expect(book_1_reviews).to eq(1)
    end

    it 'will titleize a user name upon creation if not already formatted correctly' do
      review_info_1 = ({title: "This book was ok",
                        user: "ricky reader",
                        rating: 3,
                        text: "You know, like if you have to read a book..."})

      review_1 = Review.new_from_form(review_info_1)

      expect(review_1.user).to eq("Ricky Reader")
    end

    it 'will not create a book if a rating is given outside of the valid range' do
      book_info_1 = ({title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com"})

      review_info_1 = ({title: "Really Bad Read",
                        user: "Bobby Badnews",
                        rating: -1,
                        text: "Extra bad text..."})
      review_info_2 = ({title: "Extra Good",
                        user: "Optimistic Oprah",
                        rating: 6,
                        text: "Extra good text..."})
      review_info_3 = ({title: "This book was ok",
                        user: "Ricky Reader",
                        rating: 3,
                        text: "You know, like if you have to read a book..."})

      book = Book.new_from_form(book_info_1)

      review_1 = book.reviews.new_from_form(review_info_1)
      review_2 = book.reviews.new_from_form(review_info_2)
      review_3 = book.reviews.new_from_form(review_info_3)

      expect(Review.count).to eq(1)
      expect(Review.all).to eq([review_3])
    end
  end
end
