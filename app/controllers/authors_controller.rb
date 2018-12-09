class AuthorsController < ApiController
  before_action :set_model, only: %i[
    show
    update
    destroy
  ]
  before_action :doorkeeper_authorize!, only: %i[
    create
    update
    destroy
  ]

  # GET /author
  def index
    @models = Author.all
    render json: @models, status: :ok
  end

  # GET /author/:id
  def show
    render json: @model, status: :ok
  end

  # POST /author
  def create
    @model = Author.create!(req_params)
    render json: @model, status: :ok
  end

  # PUT /author/:id
  def update
    render json: @model, status: :ok
  end

  # DELETE /author/:id
  def destroy
    @model.destroy
    render json: @model, status: :ok
  end

  private

  def req_params
    # whitelist params
    params.permit(:first_name, :last_name, :group)
    # params.permit(:authors, )
  end

  def set_model
    @model = Author.where(id: params[:id]).first
    render plain: 'Author Not Found!', status: :not_found if @model.nil?
  end
end
