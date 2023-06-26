class ActivitiesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :error_response
    
    def index
        activities = Activity.all
        render json: activities
    end

    def show
        activities = find_params
        render json: activities
    end

    def destroy
        activities = find_params
        activities.destroy
    end

    private
    def find_params
        Activity.find(params[:id])
    end

    def error_response
        render json: {error: 'Activity not found'}, status: :not_found
    end
end
