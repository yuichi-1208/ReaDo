class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new
    @books = []

    if params[:book_title].present?
      @title = params[:book_title]
      if @title.present?
        results = RakutenWebService::Books::Book.search({
          title: @title,
          hits: 20,
        })

        results.each do |result|
          book = Book.new(read(result))
          @books << book
        end
      end
    else
      @books = Book.all
    end

    @books = Kaminari.paginate_array(@books).page(params[:page]).per(10)
  end

  def create
    @book = Book.find_or_initialize_by(isbn: params[:isbn])

    unless @book.persisted?
      results = RakutenWebService::Books::Book.search(isbn: @book.isbn)
      @book = Book.new(read(results.first))
      @book.save
    end
    if params[:commit] == "要約"
      redirect_to new_book_summary_path(@book)
    else
      redirect_to new_book_memo_path(@book)
    end
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews
    @review = @book.reviews.build
  end

  private

  def read(result)
    title = result['title']
    url = result['itemUrl']
    isbn = result['isbn']
    image_url = result['largeImageUrl'].gsub('?_ex=150x150', '')
    author = result['author']
    publisher = result['publisherName']

    {
      title: title,
      url: url,
      isbn: isbn,
      image_url: image_url,
      author: author,
      publisher: publisher
    }
  end

  def set_book
    @book = Book.find(params[:isbn])
  end
end
