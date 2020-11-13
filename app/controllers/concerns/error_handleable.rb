module ErrorHandleable
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    protected

    def render_unprocessable_entity_response(exception)
      render json: {
        message: I18n.t('http_status.unprocessable_entity'),
        errors: ErrorsSerializer.new(exception.record).serialize
      }, status: :unprocessable_entity
    end

    def render_not_found_response(exception)
      render json: {
        message: I18n.t('http_status.record_not_found'),
        errors: { field: exception.model || 'record', code: 'not_found' }
      }, status: :not_found
    end

    def render_forbidden_response
      render json: {
        message: I18n.t('http_status.forbidden'),
        errors: { field: 'code', code: 'forbidden' }
      }, status: :forbidden
    end

    def respond_with_errors(obj)
      render json: {
        message: I18n.t('http_status.unprocessable_entity'),
        errors: ErrorsSerializer.new(obj).serialize
      }, status: :unprocessable_entity
    end
  end
end
