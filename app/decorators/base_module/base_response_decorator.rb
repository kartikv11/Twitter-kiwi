module BaseModule
  class BaseResponseDecorator
    # Define utils globally with versioning
    # Kept them as global constants, so that they are specific
    # to this class only
    RESPONSE_CODES_UTIL = CommonModule::ResponseCodes
    CONTENT_UTIL = CommonModule::Content

    #
    # Send Bad-Request response code back to user
    #
    def self.create_response_bad_request(message = '')
      message = message.present? ? message : CONTENT_UTIL::INSUFFICIENT_DATA
      response = {
        error: { message: message },
        response: RESPONSE_CODES_UTIL::BAD_REQUEST
      }
      return response
    end

    #
    # Send Bad-Request response code back to user
    #
    def self.create_response_invalid_data_passed(message = '')
      message = message.present? ? message : CONTENT_UTIL::INVALID_DATA_PASSED
      response = {
        error: { message: message },
        response: RESPONSE_CODES_UTIL::BAD_REQUEST
      }
      return response
    end


    #
    # Send Internal server error response code back to user
    #
    def self.create_response_runtime_error(message = '')
      message = message.present? ? message : CONTENT_UTIL::RUN_TIME_ERROR
      response = {
        error: { message: message },
        response: RESPONSE_CODES_UTIL::INTERNAL_SERVER_ERROR
      }

      return response
    end

    #
    # Send Bad-Authentication Timeout response code back to user
    #
    def self.create_request_timeout_error(message = '')
      message = message.present? ? message : CONTENT_UTIL::AUTHENTICATION_TIMEOUT
      response = {
        error: { message: message },
        response: RESPONSE_CODES_UTIL::AUTHENTICATION_TIMEOUT
      }
      return response
    end


    #
    # Send Bad-Authentication Timeout response code back to user
    #
    def self.create_not_found_error(message = '')
      message = message.present? ? message : CONTENT_UTIL::NOT_FOUND
      response = {
        error: { message: message },
        response: RESPONSE_CODES_UTIL::NOT_FOUND
      }
      return response
    end

    #
    # send information not found message to user with
    # appropriate error message
    #
    # @param message [String] [message to be sent to user as it is]
    #
    def self.create_information_not_found(message = '')
      {
        error: { message: message },
        response: RESPONSE_CODES_UTIL::BAD_REQUEST
      }
    end

    # Create response for invalid arguments
    #
    # @param message [String] consist of message why validaton fails
    #
    # @return [hash] response of invalid arguments
    #
    def self.create_response_invalid_arguments_error(message = '')
      {
        error: { message: message },
        response: RESPONSE_CODES_UTIL::BAD_REQUEST
      }
    end

    #
    # Fucntion to create success response
    #
    def self.create_success_response
      response = {
        payload: { message: CONTENT_UTIL::OK_RESPONSE },
        response: RESPONSE_CODES_UTIL::SUCCESS
      }
      return response
    end

    def self.create_validation_failed_response(message)
      {
        error: { message: message },
        response: RESPONSE_CODES_UTIL::BAD_REQUEST
      }
    end

    def self.create_response_unauthorized_access(message = '')
      message = message.present? ? message : CONTENT_UTIL::UNAUTHORIZED_USER
      {
        error: { message: message },
        response: RESPONSE_CODES_UTIL::FORBIDDEN
      }
    end

  end
end
