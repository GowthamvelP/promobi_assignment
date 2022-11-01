class ApplicationController < ActionController::API
  include Pagy::Backend
  include ApiResponders
  include ApiExceptions
  include Pagination
end
