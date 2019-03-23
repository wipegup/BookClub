class ReviewsController < ApplicationController
  def index
    @user_name = params[:user]
    @reviews = Review.where(user: @user_name)
  end

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new_from_form(review_params)
    redirect_to book_path(@book)
  end

private

  def review_params
    params.require(:review).permit(:title, :user, :rating, :text)
  end
end
