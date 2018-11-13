class AuthorsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_model, only: [
    :show,
    :update,
    :destroy
  ]
  # before_action :authenticate_user!, only: [
  #   :create,
  #   :update,
  #   :destroy
  # ]
  
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
    @model = Book.find(params[:id])
  end

end
