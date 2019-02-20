module Api
  module Concerns
    module ActAsApiRequest
      extend ActiveSupport::Concern

      included do
        before_action :authenticate
        before_action :check_json_request
      end

      def authenticate
        if request.headers['Authorization'] != Rails.application.credentials.dig(:authentication_secret)
          render_error(:not_authorize, 'Invalid authentication secret')
        end
      end

      def check_json_request
        return if request.format.json?
        render_error(:not_acceptable, 'Invalid request type')
      end

      def pagination_dict(collection)
        {
          current_page: collection.current_page,
          next_page: collection.next_page,
          prev_page: collection.prev_page, # use collection.previous_page when using will_paginate
          total_pages: collection.total_pages,
          total_count: collection.total_count
        }
      end

      def render_error(status, message, _data = nil)
        response = {
          error: message
        }
        render json: response, status: status
      end

      def render_success_with_pagination(response)
        render json: response, meta: pagination_dict(response), adapter: :json
      end
    end
  end
end
