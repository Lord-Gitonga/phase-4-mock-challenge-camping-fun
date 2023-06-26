class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :error_response
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_respone   
    def index
        campers = Camper.all
        render json: campers
    end

    def show 
        campers = campers_params
        render json: campers
    end

    def create
      camper = Camper.create!(my_params)
      render json: camper.to_json(except: [:activities, :created_at, :updated_at]), status: :created
    end

    private
    def campers_params
        Camper.find(params[:id])
    end

    def my_params 
        params.permit(:name, :age)
    end

    def render_record_invalid_respone(invalid)
        render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def error_response
        render json: {error: "Camper not found"}, status: :not_found
    end
end
