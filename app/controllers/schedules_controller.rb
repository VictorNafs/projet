class SchedulesController < ApplicationController
  include ProductAvailabilityHelper

  def day_schedule
    @date = Date.parse(params[:date])
    @reservations_by_hour = Reservation.where(start_time: @date.beginning_of_day..@date.end_of_day).group_by { |r| r.start_time.hour }
    @products = available_products(@date).limit(2)
  end
end
