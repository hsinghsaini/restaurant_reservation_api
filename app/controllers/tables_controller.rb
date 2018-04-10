class TablesController < ApplicationController
  before_action :set_restaurant
  before_action :set_table, only: [:show, :update, :destroy]

  def index
    @tables = @restaurant.tables

    render json: @tables
  end

  def show
    render json: @table
  end

  def create
    @table = @restaurant.tables.new(table_params)

    if @table.save
      render json: @table, status: :created
    else
      render json: @table.errors, status: :unprocessable_entity
    end
  end

  def update
    if @table.update(table_params)
      render json: @table
    else
      render json: @table.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @table.destroy
  end

  private
    def set_table
      @table = @restaurant.tables.find_by(id: params[:id])
      render json: (I18n.t "table.not_found"), status: :unprocessable_entity and return unless @table
    end

    def table_params
      params.require(:table).permit(:name, :minimum_guests, :maximum_guests)
    end
end
