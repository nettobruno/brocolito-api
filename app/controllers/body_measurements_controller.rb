class BodyMeasurementsController < ApplicationController
  before_action :authenticate_request
  before_action :set_body_measurement, only: [:show, :update, :destroy]

  # GET /body_measurements
  def index
    @body_measurements = current_user.body_measurements

    render json: @body_measurements
  end

  def compare
    first = current_user.body_measurements.order(created_at: :asc).first
    last = current_user.body_measurements.order(created_at: :desc).first


    if first && last
      comparison = {
        weight_change_kg: measurement_change(first, last, :weight_kg),
        neck_circumference_change_cm: measurement_change(first, last, :neck_circumference_cm),
        chest_circumference_change_cm: measurement_change(first, last, :chest_circumference_cm),
        shoulder_circumference_change_cm: measurement_change(first, last, :shoulder_circumference_cm),
        waist_circumference_change_cm: measurement_change(first, last, :waist_circumference_cm),
        hip_circumference_change_cm: measurement_change(first, last, :hip_circumference_cm),
        abdomen_circumference_change_cm: measurement_change(first, last, :abdomen_circumference_cm),
        relaxed_arm_circumference_change_cm: measurement_change(first, last, :relaxed_arm_circumference_cm),
        flexed_arm_circumference_change_cm: measurement_change(first, last, :flexed_arm_circumference_cm),
        forearm_circumference_change_cm: measurement_change(first, last, :forearm_circumference_cm),
        thigh_circumference_change_cm: measurement_change(first, last, :thigh_circumference_cm),
        calf_circumference_change_cm: measurement_change(first, last, :calf_circumference_cm)
      }

      render json: comparison
    else
      render json: { error: "Not enough data to compare" }, status: :unprocessable_entity
    end
  end

  # GET /body_measurements/1
  def show
    render json: @body_measurement
  end

  # POST /body_measurements
  def create
    @body_measurement = current_user.body_measurements.new(body_measurement_params)

    if @body_measurement.save
      render json: @body_measurement, status: :created, location: @body_measurement
    else
      render json: @body_measurement.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /body_measurements/1
  def update
    if @body_measurement.update(body_measurement_params)
      render json: @body_measurement
    else
      render json: @body_measurement.errors, status: :unprocessable_entity
    end
  end

  # DELETE /body_measurements/1
  def destroy
    @body_measurement.destroy
    render json: { message: "Body measurement deleted successfully" }
  end

  private

    def set_body_measurement
      @body_measurement = current_user.body_measurements.find(params[:id])
    end

    def body_measurement_params
      params.require(:body_measurement).permit(
        :weight_kg,
        :height_cm,
        :neck_circumference_cm,
        :chest_circumference_cm,
        :shoulder_circumference_cm,
        :waist_circumference_cm,
        :hip_circumference_cm,
        :abdomen_circumference_cm,
        :relaxed_arm_circumference_cm,
        :flexed_arm_circumference_cm,
        :forearm_circumference_cm,
        :thigh_circumference_cm,
        :calf_circumference_cm
      )
    end

    def measurement_change(first, last, field)
      return nil if first[field].nil? || last[field].nil?

      last[field] - first[field]
    end
end
