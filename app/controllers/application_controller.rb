class ApplicationController < ActionController::API
  include ApiResponders
  include ApiExceptions
  include Pagination
end
