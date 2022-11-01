module ApiResponders
  extend ActiveSupport::Concern

  private

  def respond_with_error(message, status = :unprocessable_entity, context = {})
    is_exception = message.kind_of?(StandardError)
    error_message = is_exception ? message.record&.errors_to_sentence : message
    render status: status, json: { success: false, message: error_message }.merge(context)
  end

  def respond_with_success(message, status = :ok, context = {})
    render status: status, json: { success: true, message: message }.merge(context)
  end

  def respond_with_json(data, metadata, status = :ok, errors = [])
    render status: status, json: construct_json(data, metadata, errors)
  end

  def construct_json(metadata, data, errors)
    {
      metadata: metadata || {},
      errors: errors || nil,
      data: data || nil
    }
  end
end
