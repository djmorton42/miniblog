class CategoriesController < ApplicationController
  def show
    unescaped_category_name = CGI.unescape(params[:name]).downcase

    @category = Category.find_for_lower_case_name(unescaped_category_name)

    raise ActionController::RoutingError.new('Not Found') unless @category.present?
    
    @entries = @category.published_entries_ordered_by_pub_date_desc
  end
end
