class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]


  impressionist :actions=> [:show]

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @bookc = Book.new
    @post_comment = PostComment.new
    impressionist(@book, nil, unique: [:session_hash.to_s])
  end

  def index
    # to  = Time.current.at_end_of_day
    # from  = (to - 6.day).at_beginning_of_day
    # @books = Book.includes(:favorited_users).
      # sort {|a,b|
      #   b.favorited_users.includes(:favorites).where(created_at: from...to).size <=>
      #   a.favorited_users.includes(:favorites).where(created_at: from...to).size
      # }
    @books = Book.all
    @book = Book.new

    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @two_days_ago_book = @books.created_two_days_ago
    @three_days_ago_book = @books.created_three_days_ago
    @four_days_ago_book = @books.created_four_days_ago
    @five_days_ago_book = @books.created_five_days_ago
    @six_days_ago_book = @books.created_six_days_ago

    @books = Book.all.order(params[:sort])
  end


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      @user = current_user
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def search_book
     @book = Book.new
     @books = Book.search(params[:keyword])
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :evaluation, :category)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
    redirect_to books_path
    end
  end

end
