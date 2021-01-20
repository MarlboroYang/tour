class CountriesController < ApplicationController
  before_action :find_country, only: [:edit, :update, :destroy, :hide, :open, :lock, :show]
  before_action :authenticate_user!

  def index
    @countries = Country.all.page(params[:page]).per(5)
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
    @cities = @country.cities.order(id: :desc).page(params[:page]).per(5)
  end

  def hide
    # 這裡的authorize是由pundit來的，用來辨識是否為可以使用的人，也就是權限的部份。
    authorize @country, :hide?
    @country.hide! if @country.may_hide?
    redirect_to countries_path, notice: '看板去旅遊了！ '
  end
  def open
    @country.open! if @country.may_open?
    redirect_to countries_path, notice: '看板回來了！ '
  end
  def lock
    @country.lock! if @country.may_lock?
    redirect_to countries_path, notice: '看板去睡了！ '
  end
  private
  # 把需要重覆的東西拿出來單獨寫一個，給需要的直接拿。
  def find_board
    @board = Board.find(params[:id])
  end

  private

  def find_country
    @country = current_user.countries.find(params[:id])
  end

  def country_params
    params.require(:country).permit(:country_name)
  end
end