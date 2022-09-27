class StoreCheckController < ApplicationController

  def index
    more_than = (store_params[:more_than] && number_or_nil(store_params[:more_than])) || 0
    less_than = (store_params[:less_than] && number_or_nil(store_params[:less_than])) || Float::INFINITY

    shoe_store = ShoeStore.where(inventory: more_than..less_than)
    shoe_store  = shoe_store.where(store: store_params[:store]) if store_params[:store].present?
    shoe_store  = shoe_store.where(model: store_params[:model]) if store_params[:model].present?

    render json: shoe_store, status: :ok
  end

  private

  def store_params
    params.permit(:store, :model, :less_than, :more_than)
  end

  def number_or_nil(string)
    Integer(string || '')
  rescue ArgumentError
    nil
  end
end