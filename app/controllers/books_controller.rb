class BooksController < ApplicationController

  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    @user = current_user
    @books = Book.all

    if @book_new.save
      flash[:notice] = "Creating successfully"
      redirect_to book_path(@book_new.id)
    else
      render :index
    end
  end

  def index
    @book_new = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @made_user = User.find(@book.user_id)
    @user = current_user
  end

  def edit
    @book_new = Book.find(params[:id])
    redirect_to books_path unless current_user.id == @book_new.user_id
  end

  def update
    @book_new = Book.find(params[:id])
    
    if @book_new.update(book_params)
      flash[:notice] = "Editing successfully"
      redirect_to book_path(@book_new.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

end
