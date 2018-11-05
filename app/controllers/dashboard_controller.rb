class DashboardController < ApplicationController
  def show
    render file: 'errors/not_found', status: 404 unless current_user

    if current_user.merchant?
      @merchant = current_user
      @users = User.joins(:orders).where('orders.user_id = ?', @merchant.id)
      @total_items_sold = @merchant.total_items_sold
      @total_items_pcnt = 0
      if @total_items_sold && @merchant.total_inventory > 0
        @total_items_pcnt = @total_items_sold / @merchant.total_inventory
      end
      @top_3_shipping_states = @merchant.top_3_shipping_states
      @top_3_shipping_cities = @merchant.top_3_shipping_cities
      @most_active_buyer = @merchant.top_active_user
      @biggest_order = @merchant.biggest_order
      @top_buyers = @merchant.top_buyers(3)
      if params[:class] == 'previous'
        previous_buyers = @merchant.previous_buyers
        respond_to do |format|
          format.csv { send_data previous_buyers.to_csv, filename: "users-#{Date.today}.csv" }
        end
      elsif params[:class] == 'new_users'
        previous_buyers = @merchant.previous_buyers
        non_buyers = @merchant.never_ordered(previous_buyers)
        respond_to do |format|
          format.html
          format.csv { send_data non_buyers.to_csv, filename: "users-#{Date.today}.csv" }
        end
      else
        render :'merchants/show'
      end
    elsif current_admin?
      @top_3_shipping_states = Order.top_shipping(:state, 3)
      @top_3_shipping_cities = Order.top_shipping(:city, 3)
      @top_buyers = Order.top_buyers(3)
      @top_merchants = User.top_merchants(3)
      @biggest_orders = Order.biggest_orders(3)
    else
      render file: 'errors/not_found', status: 404
    end
  end
end
