module Api
  module V1
    class ApiController < ActionController::API
      include Api::Concerns::ActAsApiRequest

      # rescue_from Exception,                           with: :render_standard_error
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
      # rescue_from ActiveRecord::RecordInvalid,         with: :render_record_invalid
      # rescue_from ActionController::RoutingError,      with: :render_not_found
      # rescue_from ActionContls -lahroller::UnknownController, with: :render_not_found
      # rescue_from AbstractController::ActionNotFound,  with: :render_not_found
      # rescue_from ActionController::ParameterMissing,  with: :render_parameter_missing

      def status
        render json: { online: true }
      end

      private

      def render_standard_error(exception)
        raise exception if Rails.env.test?
        render_error(500, 'Unable to process request') unless performed?
      end

      def render_not_found(exception)
        render_error(:not_found, exception.message)
      end

      def render_record_invalid(exception)
        render_error(:bad_request, exception.record.errors.as_json)
      end

      def render_parameter_missing(exception)
        render_error(:unprocessable_entity, 'Params are missing')
      end
    end
  end
end
