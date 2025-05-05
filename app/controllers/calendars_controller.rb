class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    getWeek
    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def getWeek
    @week_days = []
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']
    @todays_date = Date.today

    plans = Plan.where(date: @todays_date..@todays_date + 6)
  
    7.times do |i|
      date = @todays_date + i
      today_plans = plans.select { |plan| plan.date == date }.map(&:plan)

      @week_days << {
        month: date.month,
        date: date.day,
        wday: wdays[date.wday],
        plans: today_plans
      }
    end
  end
end
