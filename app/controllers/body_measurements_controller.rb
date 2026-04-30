class BodyMeasurementsController < ApplicationController
  before_action :set_body_measurement, only: [:show, :update, :destroy]

  # GET /body_measurements
  def index
    @body_measurements = BodyMeasurement.all

    render json: @body_measurements
  end

  # GET /body_measurements/1
  def show
    render json: @body_measurement
  end

  # POST /body_measurements
  def create
    @body_measurement = BodyMeasurement.new(body_measurement_params)

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
  end

  private

    def set_body_measurement
      @body_measurement = BodyMeasurement.find(params[:id])
    end

    def body_measurement_params
      params.require(:body_measurement).permit(
        :user_id,
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
end
