class TrainingCheckInsController < ApplicationController
  before_action :authenticate_request

  def index
    check_ins = current_user.training_check_ins
      .between_dates(parse_date(params[:start_date]), parse_date(params[:end_date]))
      .ordered

    render json: check_ins
  end

  def today
    check_in = current_user.training_check_ins.find_by(date: Date.current)

    render json: serialize_check_in(check_in || TrainingCheckIn.default_for(Date.current), persisted: check_in.present?)
  end

  def upsert_today
    check_in = current_user.training_check_ins.find_or_initialize_by(date: Date.current)

    if check_in.update(training_check_in_params)
      render json: serialize_check_in(check_in, persisted: true)
    else
      render json: check_in.errors, status: :unprocessable_entity
    end
  end

  private

    def training_check_in_params
      params.require(:training_check_in).permit(:trained, :notes, activities: [])
    end

    def parse_date(value)
      Date.iso8601(value) if value.present?
    rescue ArgumentError
      nil
    end

    def serialize_check_in(check_in, persisted:)
      check_in.as_json.merge("checked_in" => persisted)
    end
end
