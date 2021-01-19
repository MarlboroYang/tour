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

  # def hide
  #   authorize @board, :hide?
  #   @board.hide! if @board.may_hide?
  #   redirect_to boards_path, notice: '看板去旅遊了！ '
  # end

  # def open
  #   @board.open! if @board.may_open?
  #   redirect_to boards_path, notice: '看板回來了！ '
  # end

  # def lock
  #   @board.lock! if @board.may_lock?
  #   redirect_to boards_path, notice: '看板去睡了！ '
  # end

  # def show
  #   @posts = @board.posts.order(id: :desc).page(params[:page]).per(10)
  # end

  private

  # def set_post
  #   @post = current_user.posts.find(params[:id])
  # end

  def find_country
    @country = current_user.countries.find(params[:id])
  end

  def country_params
    params.require(:country).permit(:country_name)
  end
end