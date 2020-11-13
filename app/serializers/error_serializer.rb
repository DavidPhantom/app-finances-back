class ErrorSerializer
  def initialize(record, field, details)
    @record = record
    @field = field
    @details = details
  end

  def serialize
    {
      resource: resource,
      field: field.camelize(:lower),
      code: code.camelize(:lower)
    }
  end

  private

  def resource
    I18n.t(
      underscored_resource_name,
      scope: [:resources],
      locale: :ru,
      default: @record.class.to_s
    )
  end

  def field
    I18n.t(
      @field,
      scope: [:fields, underscored_resource_name],
      locale: :ru,
      default: @field.to_s
    )
  end

  def code
    I18n.t(
      @details[:error],
      scope: [:errors, :codes],
      locale: :ru,
      default: @details[:error].to_s
    )
  end

  def underscored_resource_name
    @record.class.to_s.gsub('::', '').underscore
  end
end
