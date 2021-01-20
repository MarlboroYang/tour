class CountriesController < ApplicationController
  before_action :find_country, only: [:edit, :update, :destroy, :hide, :open, :lock, :show]
  before_action :authenticate_user!

  def index
    @countries = Country.all
  end

  def new 
    @country = Country.new
  end

  def create
    @country = current_user.countries.new(country_params)
    if @country.save
      redirect_to countries_path, notice: "新增成功"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @country.update(country_params)
      redirect_to countries_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    @country.destroy
    redirect_to countries_path, notice: "看版已刪除"
  end


  def show
    @cities = @country.cities.order(id: :desc)
  end

  private

  def find_country
    @country = current_user.countries.find(params[:id])
  end

  def country_params
    params.require(:country).permit(:country_name)
  end
end