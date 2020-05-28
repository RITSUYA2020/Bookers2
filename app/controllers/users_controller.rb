class UsersController < ApplicationController

	def index
		@users = User.all
		@new_book = Book.new
		@user = current_user
	end

	def create
  		@book = Book.new(book_params)
  		if @book.save
  			flash[:notice] = "You have creatad book successfully."
  			redirect_to book_path(@book.id)
  		else
  		#indexページの表示処理
  			redirect_to books_path
  		end
  	end

	def show
		@user = User.find(params[:id])
		@books = @user.books
		@new_book = Book.new
	end

	def edit
		@user = User.find(params[:id])
		if current_user.id != @user.id
			redirect_to user_path(current_user.id)
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "You have updated user successfully."
			redirect_to user_path(@user.id)
		else
			render :edit
		end
	end

	def new
	end

	private
	def user_params
		params.require(:user).permit(:name,:profile_image,:introduction)
	end

end
