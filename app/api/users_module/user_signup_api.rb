#
# Module to handle functionalities related to User
#
module UsersModule
  #
  # API to sign up user
  #
  class UserSignupApi < BaseModule::BaseApi

    USER_SERVICE = UsersModule::UserService
    USER_RESPONSE_DECORATOR = UsersModule::UserResponseDecorator

    def initialize(params = '')
      @params = params
    end

    #
    # Validate signup request hash and registers user
    #
    # @return [Response] [response to be sent to the user]
    #
    def enact(request)
      begin
        validate_check_signup_request(request)
        user_service = USER_SERVICE.new(@params)
        response = user_service.signup(request)
        return USER_RESPONSE_DECORATOR.create_signup_response
      rescue CUSTOM_ERROR_UTIL::UnAuthenticatedUserError => e
        return USER_RESPONSE_DECORATOR.create_response_unauthenticated_user(e.message)
      rescue CUSTOM_ERROR_UTIL::InsufficientDataError, CUSTOM_ERROR_UTIL::InvalidDataError, CUSTOM_ERROR_UTIL::InvalidArgumentsError => e
        return USER_RESPONSE_DECORATOR.create_response_bad_request(e.message)
      end
    end

    #
    # Function to validate signup request
    #
    def validate_check_signup_request(request)
      if request[:user_name].blank? || request[:name].blank? || request[:email_id].blank? ||
        request[:password].blank? || request[:password_confirmation].blank?
        raise CUSTOM_ERROR_UTIL::InsufficientDataError.new(CONTENT_UTIL::INSUFFICIENT_DATA)
      end

      unless request[:password] == request[:password_confirmation]
        raise CUSTOM_ERROR_UTIL::InvalidDataError.new(CONTENT_UTIL::PASSWORD_MISMATCH)
      end
    end

  end
end
