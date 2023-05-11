class SchedulesController < ApplicationController
    def day_schedule
      @date = Date.parse(params[:date])
    end
  end
  
  class SchedulesController < ApplicationController
    def day_schedule
      @date = Date.parse(params[:date])
      @reservations_by_hour = Reservation.where(start_time: @date.beginning_of_day..@date.end_of_day).group_by { |r| r.start_time.hour }
    end
    

  end
  