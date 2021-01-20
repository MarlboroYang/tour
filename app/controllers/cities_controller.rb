class CitiesController < ApplicationController
  before_action :find_city, only: [:edit, :update, :destroy, :hide, :open, :lock, :show]
  before_action :set_country, only: [:new, :create]
  before_action :authenticate_user!

  def index
    @cities = City.all
  end

  def new 
    @city = City.new
  end

  def create
    @city = current_user.cities.new(city_params)
    @city.country = @country
    if @city.save
      redirect_to country_path(@country), notice: "新增成功"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @city.update(city_params)
      @country = @city.country
      redirect_to country_path(@country), notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    @country = @city.country
    @city.destroy
    redirect_to country_path(@country), notice: "看版已刪除"
  end

  def show
  end


  private

  def set_country
    @country = current_user.countries.find(params[:country_id])
  end

  def find_city
    @city = current_user.cities.find(params[:id])
  end

  def city_params
    params.require(:city).permit(:city_name, :content)
  end
end