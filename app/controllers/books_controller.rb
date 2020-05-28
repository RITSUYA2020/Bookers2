class BooksController < ApplicationController

before_action :ensure_current_user,{only: [:edit, :update, :destroy]}

	def create
  		@new_book = Book.new(book_params)
  		@new_book.user_id = current_user.id
  		if @new_book.save
  			flash[:notice] = "You have creatad book successfully."
  			redirect_to book_path(@new_book.id)
  		else
  			#indexページの表示処理
  			@books = Book.all
  			@user = @new_book.user
  			render :index
  		end
  	end

	#indexページの表示処理
  	def index
		@books = Book.all
		@new_book = Book.new
		@user = current_user
	end

	def show
		@book = Book.find(params[:id])
		@user = @book.user
		@new_book = Book.new
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		@new_book = Book.new
		if @book.update(book_params)
			flash[:notice] = "Book was successfully created."
			redirect_to book_path(@book.id)
		else
			@user = @book.user
			render :edit
		end
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end

	private
	def book_params
		params.require(:book).permit(:title, :body)
	end
	def ensure_current_user
		@book = Book.find_by(id: params[:id])
		if current_user.id != @book.user_id
			redirect_to books_path
		end
	end

end
