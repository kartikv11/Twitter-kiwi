# Utility to store all kind of status codes used overall
module CommonModule
  class StatusCodes < BaseModule::BaseUtil
    SUCCESS = 200
    NO_CONTENT = 204
    BAD_REQUEST = 400
    UN_AUTHORIZED = 401
    FORBIDDEN = 403
    NOT_FOUND = 404
    AUTHENTICATION_TIMEOUT = 419
    UNPROCESSABLE_ENTITY = 422
    PRE_CONDITION_REQUIRED = 428
    TOO_MANY_REQUESTS = 429
    INTERNAL_SERVER_ERROR = 500
    PRE_CONDITION_FAILED = 412
    CONFLICT_IN_STATE = 409
  end
end
