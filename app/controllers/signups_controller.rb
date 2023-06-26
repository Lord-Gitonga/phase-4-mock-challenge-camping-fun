class SignupsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_respone  
    def index
        signups = Signup.all
        render json: signups
    end

    def create
        signup = Signup.create!(activity_params)
        render json: signup, status: :created
    end

    def show
        signup = find_signup
        render json: signup
    end

    def destroy
        signup = find_signup
        signup.destroy
    end

    private
    def activity_params
        params.permit(:time, :camper_id, :activity_id)
    end

    def find_signup
        Signup.find(params[:id])
    end

    def render_not_found_response
        render json: {error: "Signup not found"}, status: :not_found
    end

     def render_record_invalid_respone(invalid)
        render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
