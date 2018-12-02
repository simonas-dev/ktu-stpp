class BooksController < ApiController
  before_action :set_model, only: [
    :show,
    :update,
    :destroy,
    :authors
  ]
  before_action :doorkeeper_authorize!, only: [
    :create,
    :update,
    :destroy
  ]
  
  # GET /author
  def index
    @models = Book.all
    render json: @models
  end

  # GET /author/:id
  def show
    render json: @model
  end

  # POST /author
  def create
    @model = Book.create!(create_params)
    render json: @model
  end

  # PUT /author/:id
  def update
    params = update_params
    params[:authors] = params[:authors].map { |a|
      author = Author.find_by(id: a[:id])
      if a[:id] != nil
        author.update(a)
      else
        author = Author.create!(a)
      end
      author
    }
    @model.update(params)
    render json: @model
  end

  # DELETE /author/:id
  def destroy
    @model.destroy
    render json: @model
  end

  # GET /author/:id/authors
  def authors
    render json: @model.authors
  end

  private

  def create_params
    params.permit(:name, :summmary, :page_count, authors: [:first_name, :last_name, :group]).tap do |permitted_params|
      if permitted_params[:authors]
        permitted_params[:authors_attributes] = permitted_params[:authors]
        permitted_params.delete(:authors)
      end
    end
  end

  def update_params
    params.permit(:name, :summmary, :page_count, authors: [:id, :first_name, :last_name, :group])
  end

  def set_model
    @model = Book.where(id: params[:id]).first
    if @model == nil
      render plain: "Book Not Found!", status: :not_found
    end
  end

end
