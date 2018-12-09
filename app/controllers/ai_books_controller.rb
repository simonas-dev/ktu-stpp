class AiBooksController < ApplicationController
  before_action :set_ai_book, only: %i[show edit update destroy]

  # GET /ai_books
  # GET /ai_books.json
  def index
    @ai_books = AiBook.all
  end

  # GET /ai_books/1
  # GET /ai_books/1.json
  def show; end

  # GET /ai_books/new
  def new
    @ai_book = AiBook.new
  end

  # GET /ai_books/1/edit
  def edit; end

  # POST /ai_books
  # POST /ai_books.json
  def create
    @ai_book = AiBook.new(ai_book_params)

    respond_to do |format|
      if @ai_book.save
        format.html { redirect_to @ai_book, notice: 'Ai book was successfully created.' }
        format.json { render :show, status: :created, location: @ai_book }
      else
        format.html { render :new }
        format.json { render json: @ai_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ai_books/1
  # PATCH/PUT /ai_books/1.json
  def update
    respond_to do |format|
      if @ai_book.update(ai_book_params)
        format.html { redirect_to @ai_book, notice: 'Ai book was successfully updated.' }
        format.json { render :show, status: :ok, location: @ai_book }
      else
        format.html { render :edit }
        format.json { render json: @ai_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ai_books/1
  # DELETE /ai_books/1.json
  def destroy
    @ai_book.destroy
    respond_to do |format|
      format.html { redirect_to ai_books_url, notice: 'Ai book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ai_book
    @ai_book = AiBook.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ai_book_params
    params.require(:ai_book).permit(:name, :summary, :page_count)
  end
end
