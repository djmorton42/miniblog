class Admin::CategoriesController < Admin::AdminAreaController
  def index
    @categories = Category
      .order(:name)
      .all
  end

  def edit
    @category = Category.find(params[:id])
    render :new
  end

  def update
    @category = Category.find(params[:id])
    @category.update_attributes(category_params)

    if @category.errors.any?
      render :new
    else
      redirect_to admin_categories_path
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)   

    if @category.errors.any?
      render :new
    else
      redirect_to admin_categories_path
    end
  end

  private
  def category_params
    params
      .require(:category)
      .permit(:name)
  end
end
