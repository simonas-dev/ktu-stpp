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
    render json: @models, status: :ok
  end

  # GET /author/:id
  def show
    render json: @model, status: :ok
  end

  # POST /author
  def create
    @model = Book.create!(create_params)
    render json: @model, status: :ok
  end

  # PUT /author/:id
  def update
    p update_params
    @model.update(update_params)
    render json: @model, status: :ok
  end

  # DELETE /author/:id
  def destroy
    @model.destroy
    render json: @model, status: :ok
  end

  # GET /author/:id/authors
  def authors
    render json: @model.authors, status: :ok
  end

  private

  def create_params
    params.permit(:name, :summary, :page_count, authors: [:first_name, :last_name, :group]).tap do |permitted_params|
      if permitted_params[:authors]
        permitted_params[:authors_attributes] = permitted_params[:authors]
        permitted_params.delete(:authors)
      end
    end
  end

  def update_params
    params.permit(:id, :name, :summary, :page_count, authors: [:id, :first_name, :last_name, :group]).tap do |permitted_params|
      if permitted_params[:authors]
        permitted_params[:authors_attributes] = permitted_params[:authors]
        permitted_params.delete(:authors)
      end
    end
  end

  def set_model
    @model = Book.find(params[:id])
  end

end
